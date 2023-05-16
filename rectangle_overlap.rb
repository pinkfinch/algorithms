=begin
https://leetcode.com/problems/rectangle-overlap/

brute force:
Input: rec1 = [0,0,2,2], rec2 = [1,1,3,3]
   c
   2  - - -
   1  - - -
   0  - - -
      0 1 2  r

      r = 0, c = 0
      move right, move up



    0,0  0,1,  1,0,  1,1
    1,0  2,0,  1,1,  1,2
    0,1  0,2   2,1,  1,1
    1,1  1,2,  2,2,  2,1

    increment row and increment column by 1 till max
    push to array

    if both have one with all 4 vertices, return true


  or r = max, c = mx
=end

def is_rectangle_overlap(rec1, rec2)
  return false if rec1[0] == rec1[2] || rec1[1] == rec1[3] || rec2[0] == rec2[2] || rec2[1] == rec2[3]
  return !(rec1[2] <= rec2[0] || rec1[3] <= rec2[1] || rec1[0] >= rec2[2] || rec1[1] >= rec2[3])
end


puts is_rectangle_overlap [0,0,2,2],[1,1,3,3]
puts is_rectangle_overlap [7,8,13,15],[10,8,12,20]

