(when (memq window-system '(mac ns))
  (setq mac-command-modifier 'meta)
  (setq mac-option-modifier 'super))
(provide 'osx)
