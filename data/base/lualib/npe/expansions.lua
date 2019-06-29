
local expansions = {}

expansions['west-expansion'] =
{
  sections =
  {
    {
      template_section = 'west-expansion',
      direction = 'west',
      template = 'template'
    }
  }
}

expansions['east-expansion'] =
{
  sections =
  {
    {
      template_section = 'east-expansion',
      direction = 'east',
      template = 'template'
    }
  }
}

expansions['final'] =
{
  sections =
  {
    {
      template_section = 'north-expansion',
      direction = 'north',
      template = 'template'
    },
    {
      template_section = 'south-expansion',
      direction = 'south',
      template = 'template'
    }
  }
}

return expansions
