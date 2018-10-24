defmodule Protos do
    @external_resource Path.expand("./match.proto", __DIR__)
    @external_resource Path.expand("./matches.proto", __DIR__)

    use Protobuf, from: Path.wildcard(Path.expand("./*.proto", __DIR__))
end