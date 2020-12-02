# PipeOperators

This lib adds a "new" pipe operator that is similar to the Maybe type on other functional programming languages.
The ~> operator will pipe values into functions unless a tuple `{:error, _}` would be sent.

# Usage
When values other than an error tuple is being piped, it acts like a normal pipe (`|>`)
```
import PipeOperators.SkipOnErrorPipe

[1, 2, 3]
~> Enum.map(fn number -> number + 1 end)

#> [2, 3, 4]
```

However, if `{:error, _}` is piped, the function is not called and error is returned.
```
import PipeOperators.SkipOnErrorPipe

{:error, "something went wrong"}
~> next_step()
~> send_message()

#> {:error, "something went wrong"}
```


## Installation

The package can be installed 
by adding `pipe_operators` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:pipe_operators, git: "https://github.com/leveexpress/pipe_operators.git", tag: "0.1"},
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/pipe_operators](https://hexdocs.pm/pipe_operators).

