defmodule PipeOperators.SkipOnErrorPipeTest do
  use ExUnit.Case, async: true

  import PipeOperators.SkipOnErrorPipe

  test "SkipOnErrorPipe should act as a normal |> when no error is returned " do
    result = [1, 2, 3]
             ~> Enum.map(fn number -> number + 1 end)
             ~> Enum.map(fn number -> number * 2 end)

    assert [4, 6, 8] == result
  end

  test "SkipOnErrorPipe should prevent further steps when an error is returned from a step" do
    result = [1, 2, 3]
             ~> fail_function()
             ~> Enum.map(fn number -> number + 1 end)

    assert {:error, "this operation failed"} == result
  end

  test "SkipOnErrorPipe should call each step only once" do
    1
    ~> send_single_message_to_process_mailbox()
    ~> send_single_message_to_process_mailbox()
    ~> send_single_message_to_process_mailbox()

    messages = :erlang.process_info(self(), :messages)

    assert messages == {:messages, [1, 1, 1]}
  end

  defp send_single_message_to_process_mailbox(item) do
    send(self(), item)
  end

  defp fail_function(_whatever) do
    {:error, "this operation failed"}
  end
end
