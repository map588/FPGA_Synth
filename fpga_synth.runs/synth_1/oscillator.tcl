# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7z020clg400-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/Matt/Documents/Vivado_Projects/fpga_synth/fpga_synth.cache/wt [current_project]
set_property parent.project_path C:/Users/Matt/Documents/Vivado_Projects/fpga_synth/fpga_synth.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part myir.com:mys-7z020:part0:2.1 [current_project]
set_property ip_repo_paths {
  c:/Users/Matt/Documents/Vivado_Projects/ip_repo
  c:/Users/Matt/AppData/Roaming/Xilinx/ip_repo
} [current_project]
update_ip_catalog
set_property ip_output_repo c:/Users/Matt/Documents/Vivado_Projects/fpga_synth/fpga_synth.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_vhdl -library xil_defaultlib {
  C:/Users/Matt/Documents/Vivado_Projects/RNG.vhd
  C:/Users/Matt/Documents/Vivado_Projects/fpga_synth/fpga_synth.srcs/sources_1/new/envelope_generator.vhd
  C:/Users/Matt/Documents/Vivado_Projects/fpga_synth/fpga_synth.srcs/sources_1/new/note_lut.vhd
  C:/Users/Matt/Documents/Vivado_Projects/fpga_synth/fpga_synth.srcs/sources_1/new/wave_generator.vhd
  C:/Users/Matt/Documents/Vivado_Projects/fpga_synth/fpga_synth.srcs/sources_1/new/oscillator.vhd
}
read_ip -quiet c:/Users/Matt/Documents/Vivado_Projects/ip_repo/dds_compiler_0_3/dds_compiler_0.xci

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Users/Matt/Documents/Vivado_Projects/MYIR_constraints.xdc
set_property used_in_implementation false [get_files C:/Users/Matt/Documents/Vivado_Projects/MYIR_constraints.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top oscillator -part xc7z020clg400-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef oscillator.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file oscillator_utilization_synth.rpt -pb oscillator_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
