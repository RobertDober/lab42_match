

# Lab42Match

[![Build Status](https://travis-ci.org/RobertDober/lab42_match.svg?branch=master)](https://travis-ci.org/RobertDober/lab42_match)
[![Gem Version](https://badge.fury.io/rb/lab42_match.svg)](http://badge.fury.io/rb/lab42_match)
[![Code Climate](https://codeclimate.com/github/RobertDober/lab42_match/badges/gpa.svg)](https://codeclimate.com/github/RobertDober/lab42_match)
[![Issue Count](https://codeclimate.com/github/RobertDober/lab42_match/badges/issue_count.svg)](https://codeclimate.com/github/RobertDober/lab42_match)
[![Test Coverage](https://codeclimate.com/github/RobertDober/lab42_match/badges/coverage.svg)](https://codeclimate.com/github/RobertDober/lab42_match)

Beyond Match Data: Modify Your Matches

... and avoid matching again

## Here is your API

## Wrap a Regex, Get a Match (object)


```ruby :include
    Match = Lab42::Match
    let(:rgx) { %r{(\d+)\.(\d*)} }
    subject { Match.new(rgx) }
```

### Query it

Example: ... to get your wrapped `Regex` back

```ruby :example
    expect( subject.rgx ).to eq(rgx)
```


... or discover that it is not matched yet

```ruby :example
    expect( subject ).not_to be_matched
```

... be aware of accessing data that is not there yet!

```ruby :example not matched yet error
    expect{ subject[0] }.to raise_error(Match::NotMatchedYet)
```

```ruby :example
    expect{ subject.capts }.to raise_error(Match::NotMatchedYet)
```

Example: And even the wrapped `MatchData` object must not be accessed

```ruby :example
    expect{ subject.match }.to  raise_error(Match::NotMatchedYet)
```

### Context Attempt an Unsuccessful Match

However after a first matching attempt the state changes and even if there was no match
your queries will now return nil instead of raising

```ruby :before
    subject.match("")
```

```ruby :example Now we are matched
    expect( subject ).to be_matched
```

```ruby :example capturess are nil
    expect( subject.capts ).to be_nil
```

```ruby :example [] returns nil
    expect( subject[0] ).to be_nil
```

### Context A Successful Match

Now things get more interesting

```ruby :include
    let(:string){ "> 42.43 <" }
    let(:match_data){ subject.rgx.match(string) }
```

```ruby :before
    subject.match(string)
```

Example: Again we are matched now
```ruby :example
    expect( subject ).to be_matched
```
Firstly let us proof that all the information of a `Regex#match` result is accessible

Example: All `MatchData` data is available

```ruby :example
    expect( subject.match ).to eq(match_data)
```

```ruby :example As are the captures
    (0..2).each do |i|
      expect( subject[i] ).to eq(match_data[i])
    end
    expect( subject.capts ).to eq(match_data.captures)
    expect( subject.subject ).to eq(string)

```

### So What?

Well the fun starts now, we can change all parts of our matches! Did you just say **all**?

Indeed I did, but let us start with the obvious ones, the captures:

Example: Increase Integer Part

```ruby :example
    replacement = subject.replace(1, "43")
    expect( replacement.string ).to eq("> 43.43 <")
    # With a block, demonstrating also that the original object has not been altered
    expect( replacement.replace(1){ |old| old.to_i.succ}.string ).to  eq("> 44.43 <")
    expect( subject.replace(1){ |old| old.to_i.succ}.string ).to eq("> 43.43 <")
```

### Context All The Parts

To demonstrate that, we need a little more complex string and regex

```ruby :include
    let(:rgx){ %r{\w+\s+(\d+)\s+(\d+)\s+\w+} }
    let(:string){ "> Hello 42 43 World <" }
    let(:matched){ Match.new(rgx, string) }
```


Here is the layout of our string, and where the parts are after a successful match

        |> |Hello |42| |43| World| <|
         ^  ^      ^  ^ ^  ^      ^
         |  |      |  | |  |      |
         |  |      |  | |  |      +---------- part[6] corresponds to MatchData#post_match
         |  |      |  | |  |                  symbolic: :last, :post or :suffix
         |  |      |  | |  +----------------- part[5] corresponds to the matched part after the last capture
         |  |      |  | |                     symbolic: :last_match
         |  |      |  | +-------------------- part[4] corresponds to the last capture
         |  |      |  |                       symbolic: :last_capture
         |  |      |  +---------------------- part[3] corresponds to the matched part between the two captures
         |  |      |
         |  |      +------------------------- part[2] corresponds to the first capture
         |  |                                 symbolic: :first_capture
         |  +-------------------------------- part[1] corresponds to the matched part before the first capture
         |                                    symbolic: :first_match
         +----------------------------------- part[0] corresponds to MatchData#pre_match
                                              symbolic: :first, :pre or :prefix

Example: Demonstrate parts

```ruby :example
    expect( matched.parts ).to eq([
        "> ", "Hello ", "42", " ", "43", " World", " <"
      ])
```

It can be seen easily that the indices used for `#replace` and to index the captures, that is 1 based can be
transformed to point to their corresponding parts by simply doubling them.

For the parts outside the captures convenient shortcuts will be provided, and only for the parts between captures you
would need to do some calculations to access them.

But then oftentimes you will make a capture group in order to change the matched text.

Let us change some parts now to see what that does

Example: Change parts by numeric index

```ruby :example
      incremented = matched.replace_part(2, 43).replace_part(-1){|s| s.reverse}
      expected = [
        "> ", "Hello ", "43", " ", "43", " World", "< "
      ]
      expect( incremented.parts ).to eq(expected)
      expect( incremented.string ).to eq(expected.join)
```

The same can be achieved by using symbolic indices which are

        first: 0
        first_capture: 2
        first_match: 1
        last: -1
        last_capture: -3
        last_match: -2
        post: -1
        pre: 0
        prefix: 0
        suffix: -1

Therefore the following will hold

Example: Change parts by symbolic name

```ruby :example
      modified = matched
        .replace_part(:first, ">>>")
        .replace_part(:first_match){ |x| x[2] }
        .replace_part(:first_capture, "43")
        .replace_part(:last_capture, "42")
        .replace_part(:last_match){ |x| x[-1] }
        .replace_part(:suffix, "<<<")
      expected_parts = [
        ">>>", "l", "43", " ", "42", "d", "<<<"
      ]
      expect( modified.parts ).to eq(expected_parts)
    
```



From this it follows directly




## Author

Copyright © 2020 Robert Dober
mailto: robert.dober@gmail.com

# LICENSE

Same as Elixir -- &#X1F609; --, which is Apache License v2.0. Please refer to [LICENSE](LICENSE) for details.

SPDX-License-Identifier: Apache-2.0
