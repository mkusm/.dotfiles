function ggr --description 'find and replace arg1 with arg2'
  git grep -l $argv[1] | xargs sed -i s/$argv[1]/$argv[2]/g;
end
