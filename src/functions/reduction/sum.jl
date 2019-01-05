import Base.sum

doc"""
    sum(x::Var, dim::Int)

Returns the sum over the given dimension.
"""
function sum(x::Var, dim::Int; keepdims=true)
    ydata = sum(x.data, dims=dim)
    s = size(ydata)
    if !keepdims
        ydata = dropdims(ydata, dims=dim)
    end
    Var(ydata, ∇sum!, (x,dim,s))
end
sum(x::Var, dims::Vector{Int}; keepdims=true) = sum(pack(x,dims,0), ndims(x), keepdims=keepdims)

function ∇sum!(y::Var, x::Var, dim::Int, s)
    isnothing(x.grad) && return
    gy = reshape(y.grad, s)
    broadcast_addto!(x.grad, gy)
end
