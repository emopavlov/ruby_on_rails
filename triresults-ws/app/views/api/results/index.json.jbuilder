json.array!(@results) do |result|
  json.partial! 'result', locals: {result: result}
end