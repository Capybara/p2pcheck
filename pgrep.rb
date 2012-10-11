def pgrep_wrap(process)
	pid = `pgrep -if #{process}`
	if pid.strip.to_i > 0
		return true
	else
		return false
	end
end

