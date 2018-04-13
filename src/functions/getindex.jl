import Base: getindex

doc"""
    getindex(x::Var, inds...)

```julia
x = Var(rand(Float32,10,5))
y = x[1:3]
y = x[2:2]
```
Note that `y = x[i]` throws an error since `y` is not a vector but a scholar.
Instead, use `y = x[i:i]`.
"""
function getindex(x::Var, inds::Tuple)
    configure!(x)
    Var(x.data[inds...], (getindex,x,inds))
end
getindex(x::Var, inds...) = getindex(x, inds)
getindex(x::Node, inds...) = Node(getindex, x, inds)

function addgrad!(y::Var, ::typeof(getindex), x::Var, inds::Tuple)
    isvoid(x.grad) && return
    gx = view(x.grad, inds...)
    add!(gx, y.grad)
end
