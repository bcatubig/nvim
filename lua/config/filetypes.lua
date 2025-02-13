vim.filetype.add {
  extension = {
    sls = 'sls.yaml',
  },
  pattern = {
    ['.*.j2'] = 'jinja',
  },
}
