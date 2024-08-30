year = 2023
month = 2
date = 9
case Date.new(year, month, date) do
  {:ok, result} -> IO.inspect(result)
  {:error, reason} -> IO.inspect("Date.new/3 is failed because of #{reason}")
end
