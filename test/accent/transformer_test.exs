defmodule Accent.TransformerTest do
  use ExUnit.Case

  describe "transform/2" do
    test "transforms the keys of a map" do
      assert Accent.Case.convert(
               %{"helloWorld" => "value"},
               Accent.Case.Snake
             ) == %{"hello_world" => "value"}
    end

    test "transforms the keys of embedded maps" do
      assert Accent.Case.convert(
               %{"helloWorld" => %{"fooBar" => "value"}},
               Accent.Case.Snake
             ) == %{"hello_world" => %{"foo_bar" => "value"}}
    end

    test "property handles arrays" do
      assert Accent.Case.convert(
               %{"helloWorld" => [%{"fooBar" => "value"}]},
               Accent.Case.Snake
             ) == %{"hello_world" => [%{"foo_bar" => "value"}]}

      assert Accent.Case.convert(
               %{"helloWorld" => ["item"]},
               Accent.Case.Snake
             ) == %{"hello_world" => ["item"]}
    end

    test "ignore transformation if given value is not Enumerable" do
      assert Accent.Case.convert(
        %{"newFile" => %Plug.Upload{}},
        Accent.Case.Snake
      ) == %{"new_file" => %Plug.Upload{}}
    end
  end
end
