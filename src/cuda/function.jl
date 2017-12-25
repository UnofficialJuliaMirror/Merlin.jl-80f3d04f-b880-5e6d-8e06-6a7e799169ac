const CuFunction_t = Ptr{Void}

mutable struct CuFunction
    ptr::CuFunction_t
    mod::CuModule # avoid CuModule gc-ed
end

function CuFunction(mod::CuModule, name::String)
    ref = Ref{CuFunction_t}()
    @apicall :cuModuleGetFunction (Ptr{CuFunction_t},CuModule_t,Ptr{Cchar}) ref mod name
    CuFunction(ref[], mod)
end

function CuFunction(code::String)
    code = replace(code, "Float32", "float")
    code = replace(code, "Float64", "double")
    code = replace(code, "Int32", "int")
    contains(code, "Array<") && (code = "$(Interop.array_h)\n$code")
    #contains(code, "Ranges<") && (code = "$range_h\n$code")

    ptx = NVRTC.compile(code)
    p = Ptr{Void}[0]
    cuModuleLoadData(p, pointer(ptx))
    mod = CuModule(p[1])

    fnames = []
    for line in split(ptx,'\n')
        m = match(r".visible .entry (.+)\(", line) # find function name
        m == nothing && continue
        push!(fnames, String(m[1]))
    end
    length(fnames) > 1 && throw("Multiple functions are found.")
    CuFunction(mod, fnames[1])
end

Base.unsafe_convert(::Type{CuFunction_t}, f::CuFunction) = f.ptr