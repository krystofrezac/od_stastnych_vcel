defmodule BeesWeb.ViewHelpers do
  @moduledoc false

  @doc """
    Add classes from options together based on parameters 

    ## Examples 

      iex> get_class(%{left: true, color: red} left: [true: "text-left"], color: [red: "text-red"])
      "text-left text-red" 
  """
  @type get_class_params :: map() | list(map()) | nil
  @type get_class_options :: keyword(keyword(String.t()))

  @spec get_class(get_class_params, get_class_options) :: String.t()
  @spec get_class(get_class_params, get_class_options, String.t()) :: String.t()
  def get_class(nil, _options), do: ""
  def get_class(params, options), do: get_class(params, options, "")
  def get_class([params | _tail], options, class), do: get_class(params, options, class)

  def get_class(params, options, class) do
    params
    |> Map.to_list()
    |> Enum.reduce(class, fn {key, value}, acc ->
      class_list = Keyword.get(options, key, [])

      new_class =
        case(Keyword.keyword?(class_list) && (is_atom(value) || is_binary(value))) do
          true ->
            Keyword.get(class_list, String.to_existing_atom("#{value}"), "")

          false ->
            ""
        end

      "#{acc} #{new_class}"
    end)
    |> String.replace(" ", " ")
  end
end
