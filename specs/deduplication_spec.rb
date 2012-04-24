require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe SecurityGuard::Deduplication do
  let :dedupe do
    SecurityGuard::Deduplication.new(
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
    dedupe.process

    File.read(fixture_file('../tmp/a.txt')).must_equal "a@example.com\nb@example.com\nc@example.com\n"
    File.read(fixture_file('../tmp/b.txt')).must_equal "d@example.com\n"
    File.read(fixture_file('../tmp/c.txt')).must_equal "e@example.com\n"
  end

  it 'dedupes an array with another array' do
    dedupe.send(:_deduped,
      ['a@example.com', 'b@example.com', 'c@example.com', 'c@example.com'],
      ['b@example.com', 'd@example.com']
    ).must_equal ['a@example.com', 'c@example.com']
  end

  it 'dedupes an array against multiple arrays' do
    dedupe.send(:_deduped_multi,
      ['c@example.com', 'd@example.com', 'e@example.com'],
      [
        ['a@example.com', 'b@example.com', 'c@example.com', 'c@example.com'],
        ['b@example.com', 'd@example.com'],
      ]
    ).must_equal ['e@example.com']
  end

  it 'dedupes the source data' do
    dedupe.send(:dedupe, source_data).must_equal [
      ['a@example.com', 'b@example.com', 'c@example.com'],
      ['d@example.com'],
      ['e@example.com'],
    ]
  end
end