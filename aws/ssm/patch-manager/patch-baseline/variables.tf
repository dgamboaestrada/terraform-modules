variable "name" {
  type        = string
  description = "(Required) The name for the patch baseline"
}

variable "description" {
  type        = string
  default     = ""
  description = "(Optional) The description that will be applied to resources created by this module"
}

variable "tags" {
  type        = map(string)
  description = "(Required) The tags to apply to the resources created by this module."
}

variable "operating_system" {
  type        = string
  description = "(Optional) Defines the operating system the patch baseline applies to. Supported operating systems include WINDOWS, AMAZON_LINUX, AMAZON_LINUX_2, SUSE, UBUNTU, CENTOS, and REDHAT_ENTERPRISE_LINUX."
}

variable "approved_patches_compliance_level" {
  type        = string
  default     = "UNSPECIFIED"
  description = "(Optional) Defines the compliance level for approved patches. This means that if an approved patch is reported as missing, this is the severity of the compliance violation. Valid compliance levels include the following: CRITICAL, HIGH, MEDIUM, LOW, INFORMATIONAL, UNSPECIFIED. The default value is UNSPECIFIED."
}
variable "approved_patches" {
  type        = list(string)
  default     = null
  description = "(Optional) A list of explicitly approved patches for the baseline."
}

variable "rejected_patches" {
  type        = list(string)
  default     = null
  description = "(Optional) A list of rejected patches."
}

variable "global_filters" {
  type        = list
  default     = []
  description = "(Optional) The global filters."
}

variable "approval_rules" {
  type        = list
  default     = []
  description = "(Optional) The approval rules"
}

variable "patch_group" {
  type        = string
  description = "(Required) The patch group name"
}
