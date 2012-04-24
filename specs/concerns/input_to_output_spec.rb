require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

class TestInputToOutput
  include SecurityGuard::Concerns::Initializable
  include SecurityGuard::Concerns::InputToOutput

  initializable :input_folder, :output_folder

  def process
    input_to_output :input   => input_folder,
                    :output  => output_folder,
                    :process => :reverse
  end

  def reverse(data)
    data.each do |lines|
      lines.reverse!
    end
    data
  end
end

describe SecurityGuard::Concerns::InputToOutput do
  let :test_io do
    TestInputToOutput.new(
      :input_folder  => fixture_file('dedupe_lists/'),
      :output_folder => fixture_file('../tmp/')
    )
  end

  let :input_data do
    [
      [1, 2, 3],
      [4, 5],
      [6, 7],
    ]
  end

  before do
    `rm -rf #{fixture_file('../tmp/*')}`
  end

  it 'reads data from the input folder' do
    input_data, filenames = test_io.send :read_data_from, fixture_file('dedupe_lists/')
    input_data.must_equal input_data
  end

  it 'records filenames' do
    input_data, filenames = test_io.send :read_data_from, fixture_file('dedupe_lists/')
    filenames.must_equal ['a.txt', 'b.txt', 'c.txt']
  end

  it 'writes data to the output folder' do
    test_io.send(:write_data_to,
      fixture_file('../tmp/'),
      :filenames   => ['a.txt', 'b.txt'],
      :output_data => [
        [1, 2, 3],
        [4, 5, 6],
      ]
    )

    File.read(fixture_file('../tmp/a.txt')).must_equal "1\n2\n3\n"
    File.read(fixture_file('../tmp/b.txt')).must_equal "4\n5\n6\n"
  end

  it 'reads input and writes output' do
    test_io.process

    File.read(fixture_file('../tmp/a.txt')).must_equal "c@example.com\nc@example.com\nb@example.com\na@example.com\n"
    File.read(fixture_file('../tmp/b.txt')).must_equal "d@example.com\nb@example.com\n"
    File.read(fixture_file('../tmp/c.txt')).must_equal "e@example.com\nd@example.com\nc@example.com\n"
  end
end