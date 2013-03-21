# University of Washington, Programming Languages, Homework 7, hw7.rb
# (See also ML code.)

# a little language for 2D geometry objects

# each subclass of GeometryExpression, including subclasses of GeometryValue,
#  needs to respond to messages preprocess_prog and eval_prog
#
# each subclass of GeometryValue additionally needs:
#   * shift
#   * intersect, which uses the double-dispatch pattern
#   * intersectPoint, intersectLine, and intersectVerticalLine for
#       for being called by intersect of appropriate clases and doing
#       the correct intersection calculuation
#   * (We would need intersectNoPoints and intersectLineSegment, but these
#      are provided by GeometryValue and should not be overridden.)
#   *  intersectWithSegmentAsLineResult, which is used by
#      intersectLineSegment as described in the assignment
#
# you can define other helper methods, but will not find much need to

# Note: geometry objects should be immutable: assign to fields only during
#       object construction

# Note: For eval_prog, represent environments as arrays of 2-element arrays
# as described in the assignment

class GeometryExpression
  # do *not* change this class definition
  Epsilon = 0.00001
end

class GeometryValue < GeometryExpression
  # do *not* change methods in this class definition
  # you can add methods if you wish

  private
  # some helper methods that may be generally useful
  def real_close(r1,r2)
    (r1 - r2).abs < GeometryExpression::Epsilon
  end
  def real_close_point(x1,y1,x2,y2)
    real_close(x1,x2) && real_close(y1,y2)
  end
  # two_points_to_line could return a Line or a VerticalLine
  def two_points_to_line(x1,y1,x2,y2)
    if real_close(x1,x2)
      VerticalLine.new x1
    else
      m = (y2 - y1).to_f / (x2 - x1)
      b = y1 - m * x1
      Line.new(m,b)
    end
  end

  def inbetween(v,end1,end2)
    ((end1 - Epsilon) <= v and v <= (end2 + Epsilon)) || ((end2 - Epsilon) <= v and v <= (end1 + Epsilon))
  end

  public
  # we put this in this class so all subclasses can inherit it:
  # the intersection of self with a NoPoints is a NoPoints object
  def intersectNoPoints np
    np # could also have NoPoints.new here instead
  end

  # we put this in this class so all subclasses can inhert it:
  # the intersection of self with a LineSegment is computed by
  # first intersecting with the line containing the segment and then
  # calling the result's intersectWithSegmentAsLineResult with the segment
  def intersectLineSegment seg
    line_result = intersect(two_points_to_line(seg.x1,seg.y1,seg.x2,seg.y2))
    line_result.intersectWithSegmentAsLineResult seg
  end
end

class NoPoints < GeometryValue
  # do *not* change this class definition: everything is done for you
  # (although this is the easiest class, it shows what methods every subclass
  # of geometry values needs)

  # Note: no initialize method only because there is nothing it needs to do
  def eval_prog env
    self # all values evaluate to self
  end
  def preprocess_prog
    self # no pre-processing to do here
  end
  def shift(dx,dy)
    self # shifting no-points is no-points
  end
  def intersect other
    other.intersectNoPoints self # will be NoPoints but follow double-dispatch
  end
  def intersectPoint p
    self # intersection with point and no-points is no-points
  end
  def intersectLine line
    self # intersection with line and no-points is no-points
  end
  def intersectVerticalLine vline
    self # intersection with line and no-points is no-points
  end
  # if self is the intersection of (1) some shape s and (2)
  # the line containing seg, then we return the intersection of the
  # shape s and the seg.  seg is an instance of LineSegment
  def intersectWithSegmentAsLineResult seg
    self
  end

  def intersect_with(v)
  end

  def intersect_with(v)
    v.intersect_with_NoPoints self
  end
  def intersect_with_NoPoints(v)
    self
  end
  def intersect_with_Point(v)
    self
  end
  def intersect_with_Line(v)
    self
  end
  def intersect_with_VerticalLine(v)
    self
  end
  def intersect_with_LineSegment(v)
    self
  end

end


class Point < GeometryValue
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods

  # Note: You may want a private helper method like the local
  # helper function inbetween in the ML code
  attr_reader :x, :y
  def initialize(x,y)
    @x = x
    @y = y
  end

  def eval_prog env
    self # all values evaluate to self
  end
  def preprocess_prog
    self # no pre-processing to do here
  end

  def shift(deltaX,deltaY)
   Point.new(@x + deltaX,@y + deltaY)
 end

 def intersect(point)
   if real_close_point(x,y,point.x,point.y)
     self
   else
    NoPoints.new
  end

end


  def intersect_with(v)
    v.intersect_with_Point self
  end
  def intersect_with_NoPoints(v)
    NoPoints.new
  end
  def intersect_with_Point(v)
    intersect(v)
  end
  def intersect_with_Line(v)
     if real_close(x,(v.x y))
       self
     else
       NoPoints.new
     end
  end
  def intersect_with_VerticalLine(v)
     if real_close(x,v.x)
      self
     else
       NoPoints.new
     end

  end
  def intersect_with_LineSegment(v)

    if inbetween(x,v.x1,v.x2) and inbetween(y,v.y1,v.y2)

      line = two_points_to_line(v.x1,v.y1,v.x2,v.y2)

      if real_close(line.y(x),y)
         self
      else
        NoPoints.new
      end

    else
      NoPoints.new
    end
  end

end

class Line < GeometryValue
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  attr_reader :m, :b
  def initialize(m,b)
    @m = m
    @b = b
  end

  def eval_prog env
    self # all values evaluate to self
  end
  def preprocess_prog
    self # no pre-processing to do here
  end

  def x y
     (y - b) /m
  end

  def y x
    (m * x) + b
  end

  def shift(deltaX,deltaY)
   Line.new(m,(@b+deltaY)-(@m*deltaX))
 end

 def intersect(line)
  if real_close(m,line.m) and real_close(b,line.b)
    self
  elsif  real_close(m,line.m) and !real_close(b,line.b)
    NoPoints.new
  else
    x_intersect = (line.b - b) / (m - line.m)
    y_intersect = m * x_intersect + b
    Point.new(x_intersect,y_intersect)
  end

end

  def intersect_with(v)
    v.intersect_with_Line self
  end
  def intersect_with_NoPoints(v)
    NoPoints.new
  end
  def intersect_with_Point(v)
     if real_close(v.x,(x v.y))
       v
     else
       NoPoints.new
     end

  end
  def intersect_with_Line(v)
    intersect(v)
  end
  def intersect_with_VerticalLine(v)
    Point(v.x, (m * v.x) + b)
  end
  def intersect_with_LineSegment(v)
    intersect(two_points_to_line(v.x1,v.y1,v.x2,v.y2))
  end

end

class VerticalLine < GeometryValue
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  attr_reader :x
  def initialize x
    @x = x
  end

  def eval_prog env
    self # all values evaluate to self
  end
  def preprocess_prog
    self # no pre-processing to do here
  end

  def shift(deltaX,deltaY)
   VerticalLine.new(@x + deltaX)
 end

 def intersect(vertica_line)
  if real_close(x,vertica_line.x)
    self
  else
    NoPoints.new
  end
end

  def intersect_with(v)
    v.intersect_with_VerticalLine self
  end
  def intersect_with_NoPoints(v)
    v
  end
  def intersect_with_Point(v)
     if real_close(x,v.x)
      v
     else
       NoPoints.new
     end
  end
  def intersect_with_Line(v)
    Point(x, (v.m * x) + v.b)
  end
  def intersect_with_VerticalLine(v)
    intersect(v)
  end
  def intersect_with_LineSegment(v)
    v.intersect(LineSegment.new(x,v.y1,x,v.y2))
  end


end

class LineSegment < GeometryValue
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  # Note: This is the most difficult class.  In the sample solution,
  #  preprocess_prog is about 15 lines long and
  # intersectWithSegmentAsLineResult is about 40 lines long
  attr_reader :x1, :y1, :x2, :y2
  def initialize (x1,y1,x2,y2)
    @x1 = x1
    @y1 = y1
    @x2 = x2
    @y2 = y2
  end

   def eval_prog env
    self # all values evaluate to self
  end
  def preprocess_prog
    if real_close_point(x1,y1,x2,y2)
      Point.new(x1,y1)
    elsif x1 <= x2 and y1 <= y2
      self
    else
      LineSegment.new(x2,y2,x1,y1)
    end
  end

  def shift(deltaX,deltaY)
   LineSegment.new(x1+deltaX,y1+deltaY,x2+deltaX,y2+deltaY)
 end

 def intersect(line_segment)

     find_point(line_segment)

 end

 def find_point(line_segment)

        x1start,y1start,x1end,y1end = x1,y1,x2,y2
        x2start,y2start,x2end,y2end = line_segment.x1,line_segment.y1,line_segment.x2,line_segment.y2

        if real_close(x1start,x1end) # self is a vertical line
           if y1start < y2start
            aXstart,aYstart,aXend,aYend  = x1,y1,x2,y2
            bXstart,bYstart,bXend,bYend  = line_segment.x1,line_segment.y1,line_segment.x2,line_segment.y2
           else
            aXstart,aYstart,aXend,aYend  = line_segment.x1,line_segment.y1,line_segment.x2,line_segment.y2
            bXstart,bYstart,bXend,bYend  = x1,y1,x2,y2
           end

            if real_close(aYend,bYstart)
               result = Point.new(aXend,aYend) # just touching
            elsif aYend < bYstart
               result = NoPoints.new # disjoint
            elsif aYend > bYend
               result = LineSegment.new(bXstart,bYstart,bXend,bYend) # b inside a
            else
               result = LineSegment.new(bXstart,bYstart,aXend,aYend)  # overlapping
            end

        else

          if x1start < x2start
            aXstart,aYstart,aXend,aYend  = x1,y1,x2,y2
            bXstart,bYstart,bXend,bYend  = line_segment.x1,line_segment.y1,line_segment.x2,line_segment.y2
           else
            aXstart,aYstart,aXend,aYend  = line_segment.x1,line_segment.y1,line_segment.x2,line_segment.y2
            bXstart,bYstart,bXend,bYend  = x1,y1,x2,y2
          end

          if real_close(aXend,bXstart)
                result = Point.new(aXend,aYend) # just touching
          elsif aXend < bXstart
                result = NoPoints.new # disjoint
          elsif aXend > bXend
                result = LineSegment.new(bXstart,bYstart,bXend,bYend) # b inside a
          else
                result = LineSegment.new(bXstart,bYstart,aXend,aYend)  # overlapping

          end
        end


 end

  def intersect_with(v)
    v.intersect_with_LineSegment self
  end

  def intersect_with_NoPoints(v)
    v
  end

  def intersect_with_Point(v)
    if inbetween(v.x,x1,x2) and inbetween(v.y,y1,y2)

      line = two_points_to_line(x1,y1,x2,y2)

      if real_close(line.y(v.x),v.y)
         v
      else
        self #NoPoints.new
      end

    else
      NoPoints.new
    end
  end

  def intersect_with_Line(v)
    intersect(LineSegment.new(x1,((v.m*x1) + v.b),x2,(v.m*x2) + v.b))
  end
  def intersect_with_VerticalLine(v)
    intersect(LineSegment.new(v.x,y1,v.x,y2))
  end
  def intersect_with_LineSegment(v)
    intersect(v)
  end


end

# Note: there is no need for getter methods for the non-value classes

class Intersect < GeometryExpression
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  def initialize(e1,e2)
    @e1 = e1
    @e2 = e2
  end

  def preprocess_prog
    self #@e1.preprocess_prog.eval_prog([]).intersect_with @e2.preprocess_prog.eval_prog([])
  end

   def eval_prog env
    @e1.preprocess_prog.eval_prog(env).intersect_with @e2.preprocess_prog.eval_prog(env)
   end


end

class Let < GeometryExpression
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  def initialize(s,e1,e2)
    @s = s
    @e1 = e1
    @e2 = e2
  end

def preprocess_prog
    self
end

def eval_prog env

  #eval_prog (e2, ((s, eval_prog(e1,env)) :: env))

  @e2.eval_prog (env << [@s,@e1.preprocess_prog.eval_prog(env)])
end

end

class Var < GeometryExpression
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  def initialize s
    @s = s
  end

  def preprocess_prog
    self
  end

 def eval_prog env
    env.each do |pair|
      return pair[1] if pair[0] == @s
    end
    raise "var not found: #{@s}"
  end


end

class Shift < GeometryExpression
  # *add* methods to this class -- do *not* change given code and do not
  # override any methods
  def initialize(dx,dy,e)
    @dx = dx
    @dy = dy
    @e = e
  end

  def preprocess_prog
    @e.preprocess_prog.eval_prog([]).shift(@dx,@dy)
  end

end
