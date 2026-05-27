import os

def generate_project_markdown(root_dir=".", output_filename="project_source_code.md"):
    # 在这里配置你想忽略的文件夹名称（非常重要，防止输出过大）
    ignore_dirs = {
        '.git', '.svn', '__pycache__', '.idea', '.vscode', 
        'node_modules', 'venv', 'env', '.next', 'dist', 'build'
    }
    
    tree_md = "## 1. 文件夹结构 (Directory Tree)\n\n"
    content_md = "## 2. 文件内容 (File Contents)\n\n"
    
    print("开始扫描文件...")
    
    # 遍历目录
    for root, dirs, files in os.walk(root_dir):
        # 原地修改 dirs 列表，跳过不需要扫描的文件夹
        dirs[:] = [d for d in dirs if d not in ignore_dirs]
        # 对文件夹排序，让输出更好看
        dirs.sort()
        
        # 计算相对路径和深度，用于 Tree 的缩进
        rel_root = os.path.relpath(root, root_dir)
        depth = 0 if rel_root == '.' else rel_root.count(os.sep) + 1
        
        # 1. 构建 Tree 的文件夹部分
        if depth > 0:
            indent = "  " * (depth - 1)
            tree_md += f"{indent}- **{os.path.basename(root)}/**\n"
        
        # 对文件按字母表排序
        files.sort()
        file_indent = "  " * depth
        
        for file in files:
            # 排除生成的 markdown 文件本身以及当前脚本，防止套娃读取
            if file == output_filename or file == os.path.basename(__file__):
                continue
            
            # 1. 构建 Tree 的文件部分
            tree_md += f"{file_indent}- {file}\n"
            
            # 2. 构建文件内容部分
            filepath = os.path.join(root, file)
            rel_filepath = os.path.relpath(filepath, root_dir)
            
            content_md += f"### {rel_filepath}\n\n"
            
            # 获取文件后缀名（用于 markdown 代码块高亮）
            ext = os.path.splitext(file)[1].lstrip('.')
            
            try:
                # 尝试以 UTF-8 编码读取文件内容
                with open(filepath, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                # 如果文件为空
                if not content.strip():
                    content_md += "*文件为空*\n\n"
                else:
                    content_md += f"```{ext}\n{content}\n```\n\n"
                    
            except UnicodeDecodeError:
                # 如果报编码错误，说明大概率是二进制文件（图片、数据库文件等）
                content_md += "*[二进制文件或不支持的编码，已跳过]*\n\n"
            except Exception as e:
                # 其他读取错误（如权限不足）
                content_md += f"*[读取文件时发生错误: {e}]*\n\n"

    # 将两部分合并写入最终的 Markdown 文件
    try:
        with open(output_filename, 'w', encoding='utf-8') as f:
            f.write("# 项目代码总览\n\n")
            f.write(tree_md)
            f.write("\n---\n\n")
            f.write(content_md)
        print(f"扫描完成！文件已保存为: {output_filename}")
    except Exception as e:
        print(f"写入 Markdown 文件时失败: {e}")

if __name__ == "__main__":
    # 执行脚本
    generate_project_markdown()
