# mnist.rb
# original: http://d.hatena.ne.jp/n_shuyo/20090913/mnist
require 'numo/narray'

module MNIST
  URL_BASE = 'http://yann.lecun.com/exdb/mnist/'
  KEY_FILE = {
    train_img: 'train-images-idx3-ubyte.gz',
    train_label: 'train-labels-idx1-ubyte.gz',
    test_img: 't10k-images-idx3-ubyte.gz',
    test_label: 't10k-labels-idx1-ubyte.gz'
  }

  DATASET_DIR = File.dirname(File.absolute_path(__FILE__))
  # SAVE_FILE = DATASET_DIR + "/mnist.dat"

  # TRAIN_NUM = 60000
  # TEST_NUM = 10000
  IMG_DIM = [1, 28, 28]
  IMG_SIZE = 784

  module_function
  def download_mnist()
    require 'open-uri'
    KEY_FILE.each_value do |filename|
      filepath = File.join(DATASET_DIR, filename)
      if !File.exist?(filepath)
        puts("Downloading #{filename} ...")
        open(filepath, "wb") do |output|
          open(URL_BASE + filename) do |data|
            output.write(data.read)
          end
        end
        puts("Done")
      end
    end
  end

  module_function
  def init_mnist()
    return if KEY_FILE.all? { |_, filename| File.exist? File.join(DATASET_DIR, filename) }
    download_mnist()
  end

  class MNISTImages
    include Enumerable

    class << self
      require 'zlib'

      def from_file(filepath, normalize=true, flatten=true)
        n_images = 0
        _images = []
        Zlib::GzipReader.open(filepath) do |f|
          magic, n_images = f.read(8).unpack('N2')
          raise 'This is not MNIST image file' if magic != 2051
          n_rows, n_cols = f.read(8).unpack('N2')
          n_images.times do
            _images << f.read(n_rows * n_cols)
          end
        end
        instance = new(_images, normalize, flatten)
        instance.instance_eval { @length = n_images }
        instance
      end
    end

    def initialize(images, normalize=true, flatten=true)
      @images = images
      @normalize = normalize
      @flatten = flatten
    end

    def length()
      @length ||= @images.length
    end
    alias :size :length

    def shape()
      @flatten ? [length, IMG_SIZE] : [length, *IMG_DIM]
    end

    def [](idx)
      _cnv_image(@images[idx])
    end

    def each()
      return to_enum(__method__) unless block_given?
      @images.each { |_image_src| yield _cnv_image(_image_src) }
      self
    end

    def to_narray()
      _cnv_image(@images)
    end

    def to_s()
      "<MNISTImages @length=#{@length}, @normalize=#{@normalize}, @flatten=#{@flatten}>"
    end
    alias :inspect :to_s

    private
    def _cnv_image(_image_src)
      if _image_src.is_a? Enumerable
        return Numo::NArray[*_image_src.map{|img|_cnv_image(img)}]
      end
      image = @flatten ?
        Numo::UInt8.from_string(_image_src) :
        Numo::UInt8.from_string(_image_src, IMG_DIM)
      if @normalize
        image = Numo::Float32.cast(image) / 255
      end
      image
    end
  end

  class MNISTLabels
    include Enumerable

    class << self
      require 'zlib'

      def from_file(filepath, one_hot=false)
        n_labels = 0
        _labels = nil
        Zlib::GzipReader.open(filepath) do |f|
          magic, n_labels = f.read(8).unpack('N2')
          raise 'This is not MNIST label file' if magic != 2049
          _labels = Numo::UInt8.from_string(f.read(n_labels))
        end
        instance = new(_labels, one_hot)
        instance.instance_eval { @length = n_labels }
        instance
      end
    end

    def initialize(labels, one_hot=false)
      @labels = labels
      @one_hot = one_hot
    end

    def length()
      @length ||= @labels.length
    end
    alias :size :length

    def shape()
      @one_hot ? [length, 10] : [length]
    end

    def [](idx)
      _cnv_label(@labels[idx])
    end

    def each()
      return to_enum(__method__) unless block_given?
      @labels.each { |_label_src| yield _cnv_label(_label_src) }
      self
    end

    def to_narray()
      _cnv_label(@labels)
    end

    def to_s()
      "<MNISTLabels @length=#{@length}, @one_hot=#{@one_hot}>"
    end
    alias :inspect :to_s

    private
    def _cnv_label(_label_src)
      if @one_hot
        if _label_src.is_a? Integer
          label = Numo::UInt8.zeros(10)
          label[_label_src] = 1
          label
        else
          l = _label_src.shape[0]
          label = Numo::UInt8.zeros(l, 10)
          l.times do |i|
            label[i, _label_src[i]] = 1
          end
          label
        end
      else
        _label_src
      end
    end
  end

  module_function
  def load_mnist(normalize: true, flatten: true, one_hot_label: false)
    init_mnist()
    train_img = MNIST::MNISTImages.from_file(
        File.join(DATASET_DIR, KEY_FILE[:train_img]), normalize, flatten)
    train_label = MNIST::MNISTLabels.from_file(
        File.join(DATASET_DIR, KEY_FILE[:train_label]), one_hot_label)
    test_img = MNIST::MNISTImages.from_file(
        File.join(DATASET_DIR, KEY_FILE[:test_img]), normalize, flatten)
    test_label = MNIST::MNISTLabels.from_file(
        File.join(DATASET_DIR, KEY_FILE[:test_label]), one_hot_label)
    return train_img, train_label, test_img, test_label
  end
end