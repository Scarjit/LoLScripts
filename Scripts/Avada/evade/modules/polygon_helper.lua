polygon_helper = {}

function polygon_helper.AddCircleToPolyGon (poly, pos, width, count)
  local points = polygon_helper.PointsFromCircle(pos, width, count, dbg)
  
  for i = 1, #points do
      poly:add(points[i].x, points[i].z)
  end
  return poly
end

function polygon_helper.PointsFromCircle (center, width, count)
  local deg = 360.0/count
  local points = {}
  for i=1, count do
    points[#points+1] = polygon_helper.RotateVector3(center, deg*i):norm()*width+center
  end
  return points
end

function polygon_helper.RotateVector3 (vector, degrees)
  local radians = degrees * (math.pi/180)
  local ca = math.cos(radians)
  local sa = math.sin(radians)
  return vec3(ca * vector.x - sa * vector.z, vector.y, sa * vector.x + ca * vector.z)
end

function polygon_helper:IsValidPolygon (poly)
  return poly:size() > 2
end

return polygon_helper