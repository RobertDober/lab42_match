

# Lab42Match

[![Build Status](https://travis-ci.org/RobertDober/lab42_match.svg?branch=master)](https://travis-ci.org/RobertDober/lab42_match)
[![Gem Version](https://badge.fury.io/rb/lab42_match.svg)](http://badge.fury.io/rb/lab42_match)
[![Code Climate](https://codeclimate.com/github/RobertDober/lab42_match/badges/gpa.svg)](https://codeclimate.com/github/RobertDober/lab42_match)
[![Issue Count](https://codeclimate.com/github/RobertDober/lab42_match/badges/issue_count.svg)](https://codeclimate.com/github/RobertDober/lab42_match)
[![Test Coverage](https://codeclimate.com/github/RobertDober/lab42_match/badges/coverage.svg)](https://codeclimate.com/github/RobertDober/lab42_match)

Beyond Match Data: Modify Your Matches

... and avoid matching again

## Here is your API

## Context: Wrap a Regex, Get a Match (object)


```ruby :include
    let(:match){ Lab42::Match.new(rgx) }
    let(:rgx) { %r{(\d+)\.(\d*)} }
```

### Query it


... to get your wrapped `Regex` back

```ruby :example Can access the wrapped Regex
    expect( match.rgx ).to eq(rgx)
```


... or discover that it is not matched yet

```ruby :example
    expect( match ).not_to be_matched
```







## Author

Copyright © 2020 Robert Dober
mailto: robert.dober@gmail.com

# LICENSE

Same as Elixir -- ;) --, which is Apache License v2.0. Please refer to [LICENSE](LICENSE) for details.

SPDX-License-Identifier: Apache-2.0

