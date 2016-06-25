workspace()
ENV["USE_CUDA"] = true
delete!(ENV, "USE_CUDA")
using Merlin
using Merlin.Caffe
using CUDA
using Base.LinAlg.BLAS
using Base.Test
using HDF5

x = Var(rand(Float32,10,5))
f = Linear(Float32,10,3)
ff = Merlin.@gradcheck f(x) (x,)

a = Merlin.@testest () (x,x)
a[2]

macro aaa(x)
  x
end
function ddd()
  a = 2
  @aaa (a,a)
end
ddd()

nprocs()
path = "C:/Users/hshindo/Desktop/nin_imagenet.caffemodel"
g = Caffe.load(path)
g.nodes

function bench()
  for i = 1:10000
    @simd for j = 1:10000
      a = rand(Float32)
    end
    #rand(Float32,100,100)
    #a * b
  end
end
@time bench()
