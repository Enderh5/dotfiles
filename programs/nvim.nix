{
  pkgs,
  ...
}:
{
  programs.neovim = {
    enable = true;
    extraLuaPackages = ps: [ ps.magick ];
    extraPackages = [
      pkgs.imagemagick
      pkgs.tree-sitter
      pkgs.marksman
      pkgs.lua-language-server
      pkgs.stylua
      pkgs.luajitPackages.luarocks-nix
      pkgs.imagemagickBig
      pkgs.imagemagick
      pkgs.nil
      pkgs.rust-analyzer
      pkgs.lldb_18
      pkgs.nixd
      pkgs.nixfmt
      pkgs.cargo
      pkgs.rustc
    ];

    extraLuaConfig = ''
      package.path = "/home/rodrigo/.config/nvim/?.lua;" .. package.path;
      require("old_init")
    '';

    plugins = [
    ];
  };

  home.file.".config/nvim/" = {
    source = ../nvim;
    recursive = true;
  };

  home.file.".config/nvim/lua/custom/plugins/image.lua" = {
    text = ''
        if vim.g.neovide then
          return {}
        end
        return {
          {
          '3rd/image.nvim',
      config = function()
        package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/?/init.lua'
        package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/?.lua'
        require('image').setup {
          backend = 'kitty',
          kitty_method = 'normal',
          integrations = {
            markdown = {
              enabled = true,
              clear_in_insert_mode = false,
              download_remote_images = true,
              only_render_image_at_cursor = true,
              filetypes = { 'markdown', 'vimwiki'},
            },
            neorg = {
              enabled = true,
              clear_in_insert_mode = false,
              download_remote_images = true,
              only_render_image_at_cursor = false,
              filetypes = { 'norg' },
            },
            html = {
              enabled = true,
            },
            css = {
              enabled = true,
            },
          },
          max_width = nil,
          max_height = nil,
          max_width_window_percentage = nil,

          max_height_window_percentage = 40,

          window_overlap_clear_enabled = false,
          window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', "" },


          tmux_show_only_in_active_window = true,

          hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.avif' },
        }

      end,
          }
        }'';
  };

  home.file.".config/nvim/lua/custom/plugins/markdownPreview.lua" = {
    text = ''
      return{{
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        ft = { 'markdown' },
        init = function()
          vim.g.mkdp_filetypes = { 'markdown' }
        end,
        config = function()
          vim.g['mkdp_preview_options'].katex = {
            macros = {
              ['\\R'] = '\\mathbb{R}',
            },
          }
          vim.g['mkdp_auto_start'] = 1
          vim.g['mkdp_auto_close'] = 0
        end,
      },
      }'';
  };

  home.file.".config/nvim/lua/custom/plugins/rustacean.lua" = {
    text = ''
      return {
        'mrcjkb/rustaceanvim',
        version = '^5', -- Recommended
        lazy = false,
        ft = { 'rust' },
      }
    '';
  };

  home.file.".config/nvim/lua/custom/plugins/typescript.lua" = {
    text = ''
      return {
        'pmizio/typescript-tools.nvim',
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
      }
    '';
  };

  home.file.".config/nvim/lua/custom/plugins/markdown.lua" = {
    text = ''
      return {{
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
        opts = {
          latex = { enabled = false },
          },

        config = function()
            require('render-markdown').setup(opts)
        end,
      }}
    '';
  };

  home.file.".config/nvim/lua/custom/plugins/jdtls.lua" = {
    text = ''
      return {
        "mfussenegger/nvim-jdtls",
        ft = "java",  -- solo carga para archivos Java
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
          local jdtls = require("jdtls")
          local config = {
            cmd = { "jdtls" },
            root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),
            settings = { java = {} },
            init_options = { bundles = {} },
          }
          jdtls.start_or_attach(config)

          vim.keymap.set("n", "<leader>co", jdtls.organize_imports, { desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>crv", jdtls.extract_variable, { desc = "Extract Variable" })
          vim.keymap.set("v", "<leader>crv", function() jdtls.extract_variable(true) end)
          vim.keymap.set("n", "<leader>crc", jdtls.extract_constant, { desc = "Extract Constant" })
          vim.keymap.set("v", "<leader>crc", function() jdtls.extract_constant(true) end)
          vim.keymap.set("v", "<leader>crm", function() jdtls.extract_method(true) end)
          vim.keymap.set("n", "<leader>d", function() jdtls.extract_method(true) end)
        end,
      }
    '';
  };

}
