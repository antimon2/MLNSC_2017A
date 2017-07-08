module LoadMnist

using PyCall
unshift!(PyVector(pyimport("sys")["path"]), "")
@pyimport mnist

function load_mnist(;normalize=true, flatten=true, one_hot_label=false)
    (x_train, t_train), (x_test, t_test) = 
        mnist.load_mnist(normalize, flatten, one_hot_label)
    return (x_train.', t_train), (x_test.', t_test)
end

export load_mnist

end