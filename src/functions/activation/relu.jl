export relu

doc"""
    relu(x)

Rectified Linear Unit.
```math
f(x) = \max(0, x)
```
"""
relu(x::Var) = Var(relu(x.data), relu, (x,))

relu(x::Node) = Node(relu, x)

function relu{T}(x::Array{T})
    y = similar(x)
    @inbounds for i = 1:length(x)
        y[i] = max(x[i], T(0))
    end
    y
end

function addgrad!(y::Var, ::typeof(relu), x::Var)
    isvoid(x.grad) && return
    ∇relu!(y.grad, x.data, x.grad)
end

function ∇relu!{T}(gy::Array{T}, x::Array{T}, gx::Array{T})
    @inbounds for i = 1:length(x)
        gx[i] += ifelse(x[i] > T(0), gy[i], T(0))
    end
end
