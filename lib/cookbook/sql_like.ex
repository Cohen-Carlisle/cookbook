defmodule Cookbook.SqlLike do
  @moduledoc """
  This module sanitizes SQL strings intended to be used in SQL LIKE statements.
  """

  @doc """
  This function finds all occurrences of the escape character, `%`, and `_`, in
  a string, returning a new string with the escape character inserted before
  each occurrence.

  The escape character defaults to `\\` but may be provided.

  This is done to escape the special characters in the SQL string and protect
  against denial of service attacks that target unsanitized LIKE queries. See
  [https://github.blog/2015-11-03-like-injection/](https://github.blog/2015-11-03-like-injection/).

  WARNING: This only prevents against LIKE DoS attacks. This is not intended to
  and does NOT protect against SQL injection. If you are interpolating directly
  into SQL queries, you must protect against SQL injection separately.

  ## Examples

      iex> SqlLike.sanitize("%as_df\\\\")
      "\\\\%as\\\\_df\\\\\\\\"

      iex> SqlLike.sanitize("%as_df!", "!")
      "!%as!_df!!"

  """
  @spec sanitize(String.t(), String.t()) :: String.t()
  def sanitize(string, escape \\ "\\") when is_binary(string) and is_binary(escape) do
    String.replace(string, [escape, "%", "_"], fn match -> escape <> match end)
  end
end
