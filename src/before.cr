macro before(df)
  def before_{{df.name}}(&callback : ({{*df.args.map(&.restriction)}}) ->)
    (@before_{{df.name}}  ||= [] of (({{*df.args.map(&.restriction)}}) ->)) << callback
  end

  {{df}}
end

macro __before__
  @before_{{@def.name}}.try &.each &.call({{*@def.args.map(&.name)}})
end
