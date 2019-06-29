local scenes = {}


scenes['biters-from-east'] = {
  type=defines.controllers.cutscene,
  waypoints={
    {
      position='target-4',
      transition_time=300,
      time_to_wait=300,
      zoom=0.5
    },
  },
  final_transition_time = 100
}


return scenes
