console.log "'Allo from CoffeeScript!"

d3.xml('images/NU Swerve.svg', 'image/svg+xml', (error, data) ->
    if (error)
        console.log('Error while loading the SVG file!', error);
    else
      data.documentElement.setAttribute("height", "100%")
      data.documentElement.setAttribute("width", "100%")
      d3.select('.container')
        .node()
        .appendChild(data.documentElement);
      d3.selectAll("#data #content").style("display", "none")
      d3.selectAll("#data #target").style("display", "none")
      d3.selectAll("#data>#content")
      d3.selectAll("#data>g").on("mouseover", () ->
        # find the targets
        group = this
        target = d3.select(this).selectAll("#target")
        source = d3.select(this).select("#label>tspan")
        sourcePos = {x: parseFloat(source.attr("x")),
        y: parseFloat(source.attr("y"))}
        target.each(() ->
          targ = d3.select(this)
          targPos = _.object(["x","y"], d3.transform(targ.attr("transform")).translate)
          d3.select(group).append("path").attr("d", d3.svg.diagonal().source(sourcePos).target(targPos))
        )
        d3.select(this).select("#content").style("display","block")
      )
      d3.selectAll("#data>g").on("mouseout", () ->
        d3.select(this).selectAll("path").remove()
        d3.select(this).select("#content").style("display","none")
      )
)


# d3.select("#CIM-Motor").append("path").attr("d", d3.svg.diagonal().source({x:parseInt(s.attr("x")), y:parseInt(s.attr("y"))}).target({x:t.translate[0], y: t.translate[1]}))
