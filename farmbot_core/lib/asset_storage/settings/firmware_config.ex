defmodule Farmbot.Asset.Settings.FirmwareConfig do
  @moduledoc false
  import Farmbot.Asset.Settings.Helpers
  require Farmbot.Logger
  @keys ~W(pin_guard_4_time_out
           pin_guard_1_active_state
           encoder_scaling_y
           movement_invert_2_endpoints_x
           movement_min_spd_y
           pin_guard_2_time_out
           movement_timeout_y
           movement_home_at_boot_y
           movement_home_spd_z
           movement_invert_endpoints_z
           pin_guard_1_pin_nr
           movement_invert_endpoints_y
           movement_max_spd_y
           movement_home_up_y
           encoder_missed_steps_decay_z
           movement_home_spd_y
           encoder_use_for_pos_x
           movement_step_per_mm_x
           movement_home_at_boot_z
           movement_steps_acc_dec_z
           pin_guard_5_pin_nr
           movement_invert_motor_z
           movement_max_spd_x
           movement_enable_endpoints_y
           movement_enable_endpoints_z
           movement_stop_at_home_x
           movement_axis_nr_steps_y
           pin_guard_1_time_out
           movement_home_at_boot_x
           pin_guard_2_pin_nr
           encoder_scaling_z
           param_e_stop_on_mov_err
           encoder_enabled_x
           pin_guard_2_active_state
           encoder_missed_steps_decay_y
           movement_home_up_z
           movement_enable_endpoints_x
           movement_step_per_mm_y
           pin_guard_3_pin_nr
           param_mov_nr_retry
           movement_stop_at_home_z
           pin_guard_4_active_state
           movement_steps_acc_dec_y
           movement_home_spd_x
           movement_keep_active_x
           pin_guard_3_time_out
           movement_keep_active_y
           encoder_scaling_x
           movement_invert_2_endpoints_z
           encoder_missed_steps_decay_x
           movement_timeout_z
           encoder_missed_steps_max_z
           movement_min_spd_z
           encoder_enabled_y
           encoder_type_y
           movement_home_up_x
           pin_guard_3_active_state
           movement_invert_motor_x
           movement_keep_active_z
           movement_max_spd_z
           movement_secondary_motor_invert_x
           movement_stop_at_max_x
           movement_steps_acc_dec_x
           pin_guard_4_pin_nr
           encoder_type_x
           movement_invert_2_endpoints_y
           encoder_invert_y
           movement_axis_nr_steps_x
           movement_stop_at_max_z
           movement_invert_endpoints_x
           encoder_invert_z
           encoder_use_for_pos_z
           pin_guard_5_active_state
           movement_step_per_mm_z
           encoder_enabled_z
           movement_secondary_motor_x
           pin_guard_5_time_out
           movement_min_spd_x
           encoder_type_z
           movement_stop_at_max_y
           encoder_use_for_pos_y
           encoder_missed_steps_max_y
           movement_timeout_x
           movement_stop_at_home_y
           movement_axis_nr_steps_z
           encoder_invert_x
           encoder_missed_steps_max_x
           movement_invert_motor_y)

  def download(new, old) do
    new = Map.take(new, @keys)
    for k <- @keys do
      if old[k] != new[k] do
        try do
          apply_kv(k, new[k], old[k])
        rescue
          _ -> Farmbot.Logger.error 1, "Failed to apply Firmware Config: #{k}"
        end
      end
    end
    :ok
  end

  def log(key, new, old) do
    Farmbot.Logger.info 3, "Firmware Config #{key} updated: #{new || "NULL"} => #{old || "NULL"}"
  end

  for key <- @keys do
    fw_float(unquote(key))
  end
end