module LoadMnist

using PyCall
unshift!(PyVector(pyimport("sys")["path"]), dirname(@__FILE__))
@pyimport mnist

function load_mnist(;normalize=true, flatten=true, one_hot_label=false)
    (x_train, t_train), (x_test, t_test) = 
        mnist.load_mnist(normalize, flatten=true) # Not to process flatten and one_hot_label
    x_train = x_train.'
    x_test = x_test.'
    if !flatten
        x_train = reshape(x_train, (28, 28, 1, size(x_train, 2)))
        x_test = reshape(x_test, (28, 28, 1, size(x_test, 2)))
    end
    if one_hot_label
        t_train = _change_one_hot_label(t_train)
        t_test = _change_one_hot_label(t_test)
    end
    return (x_train, t_train), (x_test, t_test)
end

function _change_one_hot_label(X::AbstractVector{UInt8})
    T = zeros(UInt8, (10, length(X)))
    for (cidx, idx) in enumerate(X)
        T[idx+1, cidx] = 1
    end
    return T
end

export load_mnist

end