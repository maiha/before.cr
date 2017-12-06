# before.cr

before hook for [Crystal](http://crystal-lang.org/).

- crystal: 0.23.1

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  before:
    github: maiha/before.cr
    version: 0.1.0
```

## Usage

##### original code

Let's image some notification application.

```crystal
class Notify
  def send(msg : String)
    # some logic to send message
  end
end
```

##### add before hook by `before.cr`

- 1. insert `before` signature befere `def`
- 2. insert `__before__` at the beginning of method body

```crystal
require "before"

class Notify
  before def send(msg : String)
    __before__
    # some logic to send message
  end
end
```

- 3. This generates following codes

```crystal
class Notify
  def before_send(&callback : (String) ->)
    (@before_send  ||= [] of ((String) ->)) << callback
  end

  def send(msg : String)
    @before_send.try &.each &.call(msg)
    # some logic to send message
  end
end
```

- 4. now you can use `before_send` block where **send** is method name

```crystal
notify = Notify.new
notify.before_send do |msg|
  raise "Do Not Disturb" unless (10..18) === Time.now.hour
end
notify.send("Come to my office now!")
```

## CAUTIONS

- variable type must be defined
- doesn't work with blocks

## Development

```shell
make test
```

## Contributing

1. Fork it ( https://github.com/maiha/before.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [maiha](https://github.com/maiha) maiha - creator, maintainer
