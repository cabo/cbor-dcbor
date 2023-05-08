# `cbor-dcbor` gem

Use with the [`cbor`][cbor-ruby] gem (or with `cbor-pure`, which is a
part of the [`cbor-diag`][cbor-diag] gem) to
add a `to_dcbor` method on objects.
Requires `to_cbor` to already be mostly deterministic (as it is for the
above two [CBOR] implementations), just adds deterministic ordering of maps
for completeness.

Note that this implements deterministic encoding as in [Section 4.2 of
RFC 8949](https://www.rfc-editor.org/rfc/rfc8949.html#section-4.2), with some additional rules as per [draft-mcnally-deterministic-cbor](https://datatracker.ietf.org/doc/draft-mcnally-deterministic-cbor/).

```ruby
require 'cbor-dcbor'

ex1 = {[]=> 1.0, aa: 2}

p CBOR.decode(ex1.to_cbor)
# {[]=>1.0, "aa"=>2}

p CBOR.decode(ex1.to_dcbor)
# {"aa"=>2, []=>1}
```

[cbor-ruby]: https://github.com/cabo/cbor-ruby
[cbor-diag]: https://github.com/cabo/cbor-diag
[CBOR]: http://cbor.io
