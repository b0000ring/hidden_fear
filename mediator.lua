local mediator = {
  subs = {}
}

function mediator:subscribe(channel, id, callback)
  if not self.subs[channel] then
    self.subs[channel] = {}
  end
  self.subs[channel][id] = {}
  table.insert(self.subs[channel][id], callback)
end

function mediator:call(channel, params)
  if self.subs[channel] then
    for k, v in pairs(self.subs[channel]) do 
      for id, callback in pairs(v) do 
        callback(params) 
      end
    end
  end
end

function mediator:unsubscribe(channel, id)
  if self.subs[channel] and self.subs[channel][id] then
    self.subs[channel][id] = nil
  end
end

return mediator