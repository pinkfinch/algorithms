
def powerset(word)
  # Write your code here
  result = []
  create_combos =-> (build, height) {
      if height == word.length
          result << build
          return
      end
      create_combos.call(build, height+1)
      create_combos.call(build + word[height], height+1)
  }

  create_combos.call("", 0)
  return result
end

#https://leetcode.com/problems/rectangle-overlap/

