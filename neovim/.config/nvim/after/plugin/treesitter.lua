if packer_plugins and packer_plugins["treesitter"] and packer_plugins["treesitter"].loaded then
    print('tresitter was loaded')
    vim.api.nvim_command(':TSUpdate')
end
