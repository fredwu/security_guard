require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe SecurityGuard::Sequences do
  let :sequences do
    SecurityGuard::Sequences.new(
      :input_folder  => fixture_file('dedupe_lists/'),
      :output_folder => fixture_file('../tmp/')
    )
  end

  let :source_data do
    [
      ['a@example.com', 'b@example.com', 'c@example.com', 'c@example.com'],
      ['b@example.com', 'd@example.com'],
      ['c@example.com', 'd@example.com', 'e@example.com'],
    ]
  end

  before do
    `rm -rf #{fixture_file('../tmp/*')}`
  end

  it 'reads input and writes output' do
    sequences.process

    File.read(fixture_file('../tmp/a.txt')).must_equal "0, a@example.com\n1, b@example.com\n2, c@example.com\n3, c@example.com\n"
    File.read(fixture_file('../tmp/b.txt')).must_equal "0, b@example.com\n1, d@example.com\n"
    File.read(fixture_file('../tmp/c.txt')).must_equal "0, c@example.com\n1, d@example.com\n2, e@example.com\n"
  end

  it 'prepends sequencial numbers to each item' do
    sequences.send(:prepend_sequencial_numbers, source_data).must_equal [
      ['0, a@example.com', '1, b@example.com', '2, c@example.com', '3, c@example.com'],
      ['0, b@example.com', '1, d@example.com'],
      ['0, c@example.com', '1, d@example.com', '2, e@example.com'],
    ]
  end
end