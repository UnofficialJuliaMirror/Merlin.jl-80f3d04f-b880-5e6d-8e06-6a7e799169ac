const T = Float64

function checkcuda(f, xs::Var...)
    eps = 1e-2
    for x in xs
        x.grad = zeros(x.data)
    end
    out = f()
    y = copy(out.data)
    gxs = map(v -> v.grad, gradient!(out))

    for x in xs
        x.data = CuArray(x.data)
        x.grad = zeros(x.data)
    end

    out = f()
    cuy = Array(out.data)
    cugxs = map(v -> Array(v.grad), gradient!(out))

    b = true
    for i = 1:length(gxs)
        diff = gxs[i] - cugxs[i]
        if any(d -> abs(d) >= eps, diff)
            println(diff)
            b = false
        end
    end
    for x in xs
        x.data = Array(x.data)
        x.grad = zeros(x.data)
    end
    b
end

@testset "functions" for i = 1:5

x = Var(rand(T,5,4))
for f in [sigmoid, tanh]
    @test checkgrad(()->f(x), x)
    #@test checkcuda(()->f(x), x)
end

x1 = Var(rand(T,10,5,2))
x2 = Var(rand(T,10,5,2))
x3 = Var(rand(T,10,5,2))
for dim = 1:3
    @test checkgrad(()->concat(dim,x1,x2,x3), x1,x2,x3)
end

x = Var(rand(T,5,4,3,2))
f = Conv(T, (2,2), (3,4), stride=(1,1), paddims=(0,0))
@test checkgrad(()->f(x), f.w, x)

p = [1:5;]
x = Var(rand(Float32,10,5))
for dim = 1:1
    @test checkgrad(()->crossentropy(p,x), x)
end

x1 = Var(rand(T,10,5,3))
x2 = Var(rand(T,5,10,3))
x3 = Var(rand(T,10,5,3))
@test checkgrad(()->gemm('N','N',0.2,x1,x2), x1, x2)
@test checkgrad(()->gemm('N','T',0.3,x1,x3), x1, x3)
@test checkgrad(()->gemm('T','N',0.4,x1,x3), x1, x3)
@test checkgrad(()->gemm('T','T',0.5,x1,x2), x1, x2)

x = Var(rand(T,10,5))
f = Linear(T,10,7)
f.b = Param(rand(T,size(f.b)))
@test checkgrad(()->f(x), f.w, x, f.b)

x1 = Var(rand(T,10,5))
x2 = Var(rand(T,10,5))
x3 = Var(rand(T,10,1))
for op in [+,-,.*]
    @test checkgrad(()->op(x1,x2), x1, x2)
    @test checkgrad(()->op(x1,x3), x1, x3)
    @test checkgrad(()->op(x3,x1), x3, x1)
end
x4 = Var(rand(T,5,7))
@test checkgrad(()->*(x1,x4), x1, x4)

x = Var(rand(T,10,5,3,4))
for dim = 1:ndims(x.data)
    @test checkgrad(()->softmax(x,dim), x)
    @test checkgrad(()->logsoftmax(x,dim), x)
end

x = Var(rand(T,10,5,4,3))
for dim = 1:ndims(x.data)
    @test checkgrad(()->sum(x,dim), x)
end

end