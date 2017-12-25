module NVRTC

if is_windows()
    const libnvrtc = Libdl.find_library(["nvrtc64_91","nvrtc64_90","nvrtc64_80","nvrtc64_75"])
else
    const libnvrtc = Libdl.find_library(["libnvrtc"])
end
isempty(libnvrtc) && warn("NVRTC library cannot be found.")

const nvrtcProgram = Ptr{Void}

function getlog(prog::Ptr{Void})
    logsize = Csize_t[0]
    nvrtcGetProgramLogSize(prog, logsize)
    log = Array(UInt8, logsize[1])
    nvrtcGetProgramLog(prog, log)
    unsafe_string(pointer(log))
end

macro apicall(f, args...)
    quote
        result = ccall(($(QuoteNode(f)),libnvrtc), Cint, $(map(esc,args)...))
        if result != 0
            Base.show_backtrace(STDOUT, backtrace())
            p = ccall((:nvrtcGetErrorString,libnvrtc), Cstring, (Cint,), result)
            throw(unsafe_string(p))
        end
    end
end

function compile(code::String; headers=(), include_names=())
    ref = Ref{nvrtcProgram}()
    headers = Ptr{Void}[pointer(h) for h in headers]
    include_names = Ptr{Void}[pointer(n) for n in include_names]
    @apicall :nvrtcCreateProgram (Ptr{nvrtcProgram},Cstring,Cstring,Cint,Ptr{Cstring},Ptr{Cstring}) ref code C_NULL length(headers) headers include_names
    prog = ref[]

    options = ["--gpu-architecture=compute_30"]
    try
        @apicall :nvrtcCompileProgram (nvrtcProgram,Cint,Ptr{Cstring}) prog length(options) options
    catch
        throw(getlog(prog))
    end

    ref = Ref{Csize_t}()
    @apicall :nvrtcGetPTXSize (nvrtcProgram,Ptr{Csize_t}) prog ref
    ptxsize = ref[]

    ptx = Array{UInt8}(ptxsize)
    @apicall :nvrtcGetPTX (nvrtcProgram,Cstring) prog ptx
    @apicall :nvrtcDestroyProgram (Ptr{nvrtcProgram,}) Ref{nvrtcProgram}(prog)

    String(ptx)
end

end