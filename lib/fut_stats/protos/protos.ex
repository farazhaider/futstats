defmodule Protos do
    @moduledoc """
    Module which compiles all the Protobuf defintions. Uses the `ex_protobuf` library.
    The compiled modules reside within the `Protos` namespace.
    """

    @external_resource Path.expand("./match.proto", __DIR__)
    @external_resource Path.expand("./matches.proto", __DIR__)
    @external_resource Path.expand("./league.proto", __DIR__)
    @external_resource Path.expand("./leagues.proto", __DIR__)

    use Protobuf, from: Path.wildcard(Path.expand("./*.proto", __DIR__))
end