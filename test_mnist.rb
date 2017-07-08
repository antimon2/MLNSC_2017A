require 'test/unit'
require_relative 'mnist'

class TestMNIST < Test::Unit::TestCase
  def test_load_mnist_train_image_length()
    tri, trl, tsi, tsl = MNIST::load_mnist()
    assert_equal 60000, tri.length
  end

  def test_load_mnist_train_label_length()
    tri, trl, tsi, tsl = MNIST::load_mnist()
    assert_equal 60000, trl.length
  end

  def test_load_mnist_test_image_length()
    tri, trl, tsi, tsl = MNIST::load_mnist()
    assert_equal 10000, tsi.length
  end

  def test_load_mnist_test_label_length()
    tri, trl, tsi, tsl = MNIST::load_mnist()
    assert_equal 10000, tsl.length
  end

  def test_load_mnist_train_image_flatten_shape()
    tri, trl, tsi, tsl = MNIST::load_mnist(flatten: true)
    assert_equal [60000, 784], tri.to_narray.shape
    assert_equal [60000, 784], tri.shape
  end

  def test_load_mnist_train_image_nonflatten_shape()
    tri, trl, tsi, tsl = MNIST::load_mnist(flatten: false)
    assert_equal [60000, 1, 28, 28], tri.to_narray.shape
    assert_equal [60000, 1, 28, 28], tri.shape
  end

  def test_load_mnist_test_image_flatten_shape()
    tri, trl, tsi, tsl = MNIST::load_mnist(flatten: true)
    assert_equal [10000, 784], tsi.to_narray.shape
    assert_equal [10000, 784], tsi.shape
  end

  def test_load_mnist_test_image_nonflatten_shape()
    tri, trl, tsi, tsl = MNIST::load_mnist(flatten: false)
    assert_equal [10000, 1, 28, 28], tsi.to_narray.shape
    assert_equal [10000, 1, 28, 28], tsi.shape
  end

  def test_load_mnist_train_label_non_onehot_shape()
    tri, trl, tsi, tsl = MNIST::load_mnist(one_hot_label: false)
    assert_equal [60000], trl.to_narray.shape
    assert_equal [60000], trl.shape
  end

  def test_load_mnist_train_label_onehot_shape()
    tri, trl, tsi, tsl = MNIST::load_mnist(one_hot_label: true)
    assert_equal [60000, 10], trl.to_narray.shape
    assert_equal [60000, 10], trl.shape
  end

  def test_load_mnist_test_label_non_onehot_shape()
    tri, trl, tsi, tsl = MNIST::load_mnist(one_hot_label: false)
    assert_equal [10000], tsl.to_narray.shape
    assert_equal [10000], tsl.shape
  end

  def test_load_mnist_test_label_onehot_shape()
    tri, trl, tsi, tsl = MNIST::load_mnist(one_hot_label: true)
    assert_equal [10000, 10], tsl.to_narray.shape
    assert_equal [10000, 10], tsl.shape
  end

  def test_load_mnist_train_image_notnormalized_type()
    tri, trl, tsi, tsl = MNIST::load_mnist(normalize: false)
    assert_equal Numo::UInt8, tri.to_narray.class
  end

  def test_load_mnist_train_image_normalized_type()
    tri, trl, tsi, tsl = MNIST::load_mnist(normalize: true)
    assert_equal Numo::Float32, tri.to_narray.class
  end

  def test_load_mnist_train_label_onehot_type()
    tri, trl, tsi, tsl = MNIST::load_mnist(one_hot_label: true)
    assert_equal Numo::UInt8, trl.to_narray.class
  end

  def test_load_mnist_train_label_not_onehot_type()
    tri, trl, tsi, tsl = MNIST::load_mnist(one_hot_label: false)
    assert_equal Numo::UInt8, trl.to_narray.class
  end

  def test_load_mnist_train_image_enumerable()
    tri, trl, tsi, tsl = MNIST::load_mnist(flatten: false)
    assert_equal [10, 1, 28, 28], Numo::NArray[*tri.take(10)].shape
  end

  def test_load_mnist_train_label_enumerable()
    tri, trl, tsi, tsl = MNIST::load_mnist(one_hot_label: true)
    assert_equal [10, 10], Numo::NArray[*trl.take(10)].shape
  end

  def test_load_mnist_test_image_enumerable()
    tri, trl, tsi, tsl = MNIST::load_mnist(flatten: false)
    assert_equal [10, 1, 28, 28], Numo::NArray[*tsi.take(10)].shape
  end

  def test_load_mnist_test_label_enumerable()
    tri, trl, tsi, tsl = MNIST::load_mnist(one_hot_label: true)
    assert_equal [10, 10], Numo::NArray[*tsl.take(10)].shape
  end
end