# Fipc

An opinionated collector and organizer of financial information for public companies that file with the SEC.

The fipc gem fetches financial information of public companies using the SEC's EDGAR API. It then processes the raw JSON data retrieved to produce organized and meaningful financial information for analyses by users.

## Installation

TODO: Replace `UPDATE_WITH_YOUR_GEM_NAME_PRIOR_TO_RELEASE_TO_RUBYGEMS_ORG` with your gem name right after releasing it to RubyGems.org. Please do not do it earlier due to security reasons. Alternatively, replace this section with instructions to install your gem from git if you don't plan to release to RubyGems.org.

Install the gem and add to the application's Gemfile by executing:

    $ bundle add UPDATE_WITH_YOUR_GEM_NAME_PRIOR_TO_RELEASE_TO_RUBYGEMS_ORG

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install UPDATE_WITH_YOUR_GEM_NAME_PRIOR_TO_RELEASE_TO_RUBYGEMS_ORG

## Usage

# How to get public company submissions that contain high-level filing information.

The information contains thing such as the company's industry and market cap.
Retrieve a hash of individual submissions with company ticker symbol as key and
the submission details as value.

Example hash:
```
{
  "AAPL"=>{:cik=>"0000320193", :entity_type=>"operating", :name=>"Apple Inc.", :ticker=>"AAPL", :industry=>"Electronic Computers", :market_cap=>"Large"},
  "GOOGL"=>{:cik=>"0001652044", :entity_type=>"operating", :name=>"Alphabet Inc.", :ticker=>"GOOGL", :industry=>"Services-Computer Programming, Data Processing, Etc.", :market_cap=>"Large"},
  ...
}
```

Run in irb like so:
```
$ irb -I lib -r fipc
> sec_edgar_submissions = Fipc::Submissions.new("John Doe", "johndoe@email.com")
> sec_edgar_submissions.fetch_all
> sec_edgar_submissions.submissions # => output described above
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/fipc. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/fipc/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Fipc project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/fipc/blob/main/CODE_OF_CONDUCT.md).
