import Base.split
export unsafe_split

function split(x::Var, dim::Int, size::Vector{Int})
    y = split(x.data, dim, size)
    Var(y, split, (x,))
end

function unsafe_split{T,N}(x::Array{T,N}, dim::Int, size::Vector{Int})
    if dim == N
        front = Base.front(Base.size(x))
        m = prod(front)
        cumsize = 0
        ys = Array{T,N}[]
        for s in size
            p = pointer(x, m*cumsize+1)
            y = unsafe_wrap(Array, p, (front...,s))
            push!(ys, y)
            cumsize += s
        end
        ys
    else
        throw("Not implemented yet.")
    end
end

function split(x::Array, dim::Int, size::Int)
    s = Base.size(x,dim) ÷ size
    s * size == Base.size(x,dim) || throw("Invalid size is specified.")
    split(x, dim, fill(s,size))
end