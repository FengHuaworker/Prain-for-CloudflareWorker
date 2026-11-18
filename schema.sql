-- Prain 清雨博客 · Cloudflare Workers 单站版 D1 结构
-- 业务表保留 site 字段（固定为 'main'），与多租户平台版共用同一套表结构。

CREATE TABLE IF NOT EXISTS conf (
  site TEXT PRIMARY KEY,
  data TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS ini (
  site TEXT NOT NULL,
  name TEXT NOT NULL,
  data TEXT NOT NULL,
  PRIMARY KEY (site, name)
);

CREATE TABLE IF NOT EXISTS article (
  site TEXT NOT NULL,
  id TEXT NOT NULL,
  cid TEXT DEFAULT '',
  path TEXT DEFAULT '',
  title TEXT DEFAULT '',
  intro TEXT DEFAULT '',
  img TEXT DEFAULT '',
  tag TEXT DEFAULT '[]',
  isTop INTEGER DEFAULT 0,
  isPrivate INTEGER DEFAULT 0,
  isComment INTEGER DEFAULT 0,
  isFk INTEGER DEFAULT 0,
  views INTEGER DEFAULT 0,
  comments INTEGER DEFAULT 0,
  createTime INTEGER DEFAULT 0,
  updateTime INTEGER DEFAULT 0,
  content TEXT DEFAULT '',
  PRIMARY KEY (site, id)
);
CREATE INDEX IF NOT EXISTS idx_article_site_time ON article(site, createTime DESC);
CREATE INDEX IF NOT EXISTS idx_article_site_cid ON article(site, cid);

CREATE TABLE IF NOT EXISTS comment (
  site TEXT NOT NULL,
  aid TEXT NOT NULL,
  id INTEGER NOT NULL,
  pid INTEGER DEFAULT 0,
  admin INTEGER DEFAULT 0,
  name TEXT DEFAULT '',
  contact TEXT DEFAULT '',
  content TEXT DEFAULT '',
  ip TEXT DEFAULT '',
  time INTEGER DEFAULT 0,
  PRIMARY KEY (site, aid, id)
);
CREATE INDEX IF NOT EXISTS idx_comment_site_aid ON comment(site, aid, id);

CREATE TABLE IF NOT EXISTS error (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  site TEXT DEFAULT '',
  ip TEXT DEFAULT '',
  url TEXT DEFAULT '',
  time INTEGER DEFAULT 0,
  content TEXT DEFAULT ''
);
CREATE INDEX IF NOT EXISTS idx_error_site_time ON error(site, time DESC);

CREATE TABLE IF NOT EXISTS file (
  site TEXT NOT NULL,
  path TEXT NOT NULL,
  name TEXT DEFAULT '',
  size INTEGER DEFAULT 0,
  mime TEXT DEFAULT '',
  time INTEGER DEFAULT 0,
  kvkey TEXT DEFAULT '',
  PRIMARY KEY (site, path)
);

-- 主题 / 扩展包索引（文件本体在 KV）
CREATE TABLE IF NOT EXISTS pkg (
  site TEXT NOT NULL,
  type TEXT NOT NULL,
  id TEXT NOT NULL,
  conf TEXT DEFAULT '{}',
  files TEXT DEFAULT '[]',
  installed INTEGER DEFAULT 0,
  time INTEGER DEFAULT 0,
  PRIMARY KEY (site, type, id)
);

CREATE TABLE IF NOT EXISTS captcha (
  site TEXT NOT NULL,
  sid TEXT NOT NULL,
  code TEXT NOT NULL,
  expires INTEGER NOT NULL,
  PRIMARY KEY (site, sid)
);
CREATE INDEX IF NOT EXISTS idx_captcha_expires ON captcha(expires);

CREATE TABLE IF NOT EXISTS visit (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  site TEXT DEFAULT '',
  ip TEXT DEFAULT '',
  path TEXT DEFAULT '',
  ua TEXT DEFAULT '',
  time INTEGER DEFAULT 0
);
CREATE INDEX IF NOT EXISTS idx_visit_site_time ON visit(site, time DESC);

