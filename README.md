# SecurityGuard [![Build Status](https://secure.travis-ci.org/fredwu/security_guard.png?branch=master)](http://travis-ci.org/fredwu/security_guard) [![Dependency Status](https://gemnasium.com/fredwu/security_guard.png)](https://gemnasium.com/fredwu/security_guard)

This gem is a collection of useful tools for auditing data and performing security checks.

## Installation

### Standalone

    $ gem install security_guard

### As part of your application

Add this line to your application's Gemfile:

    gem 'security_guard'

And then execute:

    $ bundle

## Usage

### Executable

There is an `sguard` command if you intend to use security_guard as a command line tool. Please refer to the help option for its usage.

    sguard -h

### Tips

You can pass in setters during initialisation, for example:

```ruby
country_ips = SecurityGuard::CountryIps.new
country_ips.countries = ['Australia', 'United Kingdom']
country_ips.ips = ['4.4.4.4', '8.8.8.8', '203.206.0.1']

# the above is equivalent to:

country_ips = SecurityGuard::CountryIps.new(
  :countries => ['Australia', 'United Kingdom'],
  :ips       => ['4.4.4.4', '8.8.8.8', '203.206.0.1']
)
```

### Country IPs

Returns a list of the IPs from given country and IP dictionaries. Useful for auditing IPs from higher risk nations.

```ruby
SecurityGuard::CountryIps.new(
  :countries => ['Australia'],
  :ips       => ['4.4.4.4', '8.8.8.8', '203.206.0.1']
).result # => ['203.206.0.1']
```

You may also pass country and IP data as a line-delimited file by appending `_from_file` at the end of the attributes:

```ruby
country_ips.countries_from_file = '/path/to/the/file'
country_ips.ips_from_file = '/path/to/the/file'
```

### Deduplication

Deduplicates line-delimited content contained within a list of files. Useful for deduplicating email newsletter subscription lists.

```ruby
SecurityGuard::Deduplication.new(
  :input_folder  => '/path/to/the/input/folder',
  :output_folder => '/path/to/the/output/folder'
).process
```

### Sequences

Prepends line-delimited content with a comma-delimited sequence column (1, 2, 3...) for counting.

```ruby
SecurityGuard::Sequences.new(
  :input_folder  => '/path/to/the/input/folder',
  :output_folder => '/path/to/the/output/folder'
).process
```

## Changelog

### v0.0.6 [2012-03-07]

- Output file names are now automatically mapped from the input file names

### v0.0.5 [2012-03-07]

- Fixed the file ordering issue on some OSes like Linux
- Fixed the non-existing `specs/tmp` directory that causes specs to fail

### v0.0.4 [2012-02-08]

- Fixed `Concerns::Initializable` for `CountryIps`
- Added `Deduplication`

### v0.0.3 [2012-01-20]

- Added `Concerns::Initializable`

### v0.0.2 [2012-01-19]

- Added IP address sanity check
- Coloured test output
- Added changelog

### v0.0.1 [2012-01-18]

- First release, implemented `CountryIps` and `bin/sguard`

## Contributing

1. Fork it
2. Make sure you add documentation to README.md
3. Make sure you test all your code
4. Do your magic!
5. Create a new Pull Request

## Author

- [Fred Wu](http://fredwu.me/)

Brought to you by [SitePoint](http://www.sitepoint.com/).
