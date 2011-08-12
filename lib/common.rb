# 
# == Synopsis
#
# Place for common routines and utilities
#
# Author:: Kyle Campos (mailto:kcampos@rsmart.com)
#

module Common
  
  def Common.dir_simplify(path)
    # Remove complex paths: /lib/../config -> /config
    path.sub(/(\w+\/\.\.\/)/, '')
  end
  
  # Return true if duration is less than amount of time elapsed
  def repeat(duration, start) 
    Time.now.to_i - start < duration ? true : false
  end
  
  # Return true if pid is alive
  def is_process_alive(pid)
    ps_ret = `ps | grep #{pid} | grep -v 'grep'`
    #puts "PS: [#{ps_ret}]"
    ps_ret != "" ? true : false
  end

end