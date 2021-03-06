# Main class, includes all other classes.
#
# lint:ignore:80chars
# lint:ignore:140chars
# @param bitlooker_enabled [Optional[Boolean]] Allow to disable bitlooker. Default value: ''.
# @param cluster_align [Optional[Integer]] Backup cluster alignment logarithm. Default value: ''.
# @param config_ensure String Ensure value for the main Veeam config file. Default value: `present`.
# @param config_path String The path to where the main Veeam config files should be stored. Default value: varies by operating system.
# @param cpu_priority [Optional[Integer]] CPU priority for veeamagents, from 0 to 19. Default value: ''.
# @param db_path [Optional[String]] Veeam database path. Default value: ''.
# @param db_schemepath [Optional[String]] Veeam database scheme path. Default value: ''.
# @param db_schemeupgradepath [Optional[String]] Veeam database upgrade scheme path. Default value: ''.
# @param freepercent_limit [Optional[Integer]] Percent of free space on block device can be used for snapshot data allocating. Default value: ''.
# @param freezethawfailure_ignore [Optional[Boolean]] Ignore freeze and thaw scripts result. Default value: ''.
# @param freezethaw_timeout [Optional[Integer]] Timeout for freeze and thaw scripts. Default value: ''.
# @param gpgkey_ca_ensure String Path to the remote Veeam CA GPG Key. Default value: varies by operating system.
# @param gpgkey_ca_local String Path to the local Veeam CA GPG Key. Default value: varies by operating system.
# @param gpgkey_ca_source String Path to the remote Veeam CA GPG Key. Default value: varies by operating system.
# @param gpgkey_ensure String Ensure value for the local Veeam GPG keys. Default value: varies by operating system.
# @param gpgkey_local String Path to the local Veeam GPG Key. Default value: varies by operating system.
# @param gpgkey_source String Path to the remote Veeam GPG Key. Default value: varies by operating system.
# @param inactivelvm_ignore [Optional[Boolean]] Ignore inactive LVM logical volumes during backup. Default value: ''.
# @param iorate_limit [Optional[Integer]] IO rate limit, from 0.01 to 1.0. Default value: ''.
# @param job_retries [Optional[Integer]] New job default retries count. Default value: ''.
# @param job_retryallerrors [Optional[Boolean]] Retry all errors, set to 'false' to enable retries only for 'snapshot overflow'. Default value: ''.
# @param log_debuglevel [Optional[Integer]] Kernel log logging level. 7 - list all messages as an error, 4 or 0 - all messages as a warning, 2 - all message as a trace (use only if veeam works perfectly on your system). Default value: ''.
# @param log_dir [Optional[String]] Logs path. Default value: ''.
# @param package_ensure String Ensure value for the Veeam package. Default value: `present`.
# @param package_manage Boolean Whether to manage the Veeam package. Default value: `true`.
# @param package_name [Array[String]] Name for the Veeam package. Default value: varies by operating system.
# @param prepost_timeout [Optional[Integer]] Timeout for pre- and post-backup scripts. Default value: ''.
# @param repo_manage Boolean Whether to manage the Veeam package repository. Default value: varies by operating system.
# @param repo_path String Path to where package repositoy files are located. Default value: varies by operating system.
# @param repo_template String Path to a template for the Veeeam package repository. Default value: `'veeamagent/veeam-repo.epp'`.
# @param service_enable Boolean Whether to enable the Veeam service. Default value: `true`.
# @param service_ensure String Ensure value for the Veeam service. Default value: `running`.
# @param service_name String Name of the Veeam service. Default value: varies by operating system.
# @param snapshot_location [Optional[String]] Location folder for snapshot data, only for 'stretch' and 'common' snapshot. Default value: ''.
# @param snapshot_maxsize [Optional[Integer]] Maximum possible snapshot data size, not for stretch snapshot. Default value: ''.
# @param snapshot_minsize [Optional[Integer]] Minimal possible snapshot data size, not for stretch snapshot. Default value: ''.
# @param snapshot_type [Optional[String]] Snapshot data type, can be 'stretch' (default) or 'common'. Default value: ''.
# @param socket_path [Optional[String]] Service socket. Default value: ''.
# @param stretchsnapshot_portionsize [Optional[Integer]] Stretch snapshot data portion. Default value: ''.
# lint:endignore
# lint:endignore
class veeamagent(
  Optional[Boolean] $bitlooker_enabled,
  Optional[Integer] $cluster_align,
  String $config_ensure,
  String $config_path,
  Optional[Integer] $cpu_priority,
  Optional[String] $db_path,
  Optional[String] $db_schemepath,
  Optional[String] $db_schemeupgradepath,
  Optional[Integer] $freepercent_limit,
  Optional[Boolean] $freezethawfailure_ignore,
  Optional[Integer] $freezethaw_timeout,
  String $gpgkey_ca_ensure,
  String $gpgkey_ca_local,
  String $gpgkey_ca_source,
  String $gpgkey_ensure,
  String $gpgkey_local,
  String $gpgkey_source,
  Optional[Boolean] $inactivelvm_ignore,
  Optional[Integer] $iorate_limit,
  Optional[Integer] $job_retries,
  Optional[Boolean] $job_retryallerrors,
  Optional[Integer] $log_debuglevel,
  Optional[String] $log_dir,
  String $package_ensure,
  Boolean $package_manage,
  Array[String] $package_name,
  Optional[Integer] $prepost_timeout,
  Boolean $repo_manage,
  String $repo_path,
  String $repo_template,
  Boolean $service_enable,
  String $service_ensure,
  String $service_name,
  Optional[String] $snapshot_location,
  Optional[Integer] $snapshot_maxsize,
  Optional[Integer] $snapshot_minsize,
  Optional[String] $snapshot_type,
  Optional[String] $socket_path,
  Optional[Integer] $stretchsnapshot_portionsize,
) {

  contain ::veeamagent::preinstall
  contain ::veeamagent::install
  contain ::veeamagent::config
  contain ::veeamagent::service

  Class['::veeamagent::preinstall']
  -> Class['::veeamagent::install']
  -> Class['::veeamagent::config']
  ~> Class['::veeamagent::service']
}
