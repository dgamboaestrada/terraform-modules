locals {
  default_approval_rules = [
    {
      compliance_level    = "UNSPECIFIED"
      enable_non_security = false

      patch_filter = [
        {
          key    = "PRODUCT",
          values = ["*"]
        },
        {
          key    = "SECTION"
          values = ["*"]
        },
        {
          key    = "PRIORITY"
          values = [
            "Required",
            "Important",
            "Standard",
            "Optional",
            "Extra",
          ]
        }
      ]
    }
  ]

  approval_rules = length(var.approval_rules) == 0 ? local.default_approval_rules : var.approval_rules
}

resource "aws_ssm_patch_baseline" "this" {
  name             = var.name
  description      = var.description
  operating_system = var.operating_system
  approved_patches = var.approved_patches
  rejected_patches = var.rejected_patches
  tags             = var.tags

  dynamic "global_filter" {
    for_each = var.global_filters

    content {
      key    = global_filter.value.key
      values = global_filter.value.values
    }
  }

  dynamic "approval_rule" {
    for_each = local.approval_rules
    content {
      approve_after_days  = try(approval_rule.value.approve_after_days, 0)
      compliance_level    = try(approval_rule.value.compliance_level, "UNSPECIFIED")
      enable_non_security = try(approval_rule.value.enable_non_security, false)

      dynamic "patch_filter" {
        for_each = approval_rule.value.patch_filter
        content {
          key    = patch_filter.value.key
          values = patch_filter.value.values
        }
      }
    }
  }
}

resource "aws_ssm_patch_group" "this" {
  baseline_id = aws_ssm_patch_baseline.this.id
  patch_group = var.patch_group
}
