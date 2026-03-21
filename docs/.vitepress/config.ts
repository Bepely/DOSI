import { defineConfig } from 'vitepress'

export default defineConfig({
  base: '/DOSI/',
  title: 'DOSI',
  description: 'Development Operational Session Instructions — a governance protocol for AI-assisted software development.',
  head: [
    ['meta', { name: 'author', content: 'Nick Gogin / Bepely' }],
    ['meta', { property: 'og:title', content: 'DOSI — AI Development Protocol' }],
    ['meta', { property: 'og:description', content: 'A structured governance protocol for AI-assisted software development. Session lifecycle, agent coordination, operational memory.' }],
  ],
  themeConfig: {
    logo: undefined,
    siteTitle: 'DOSI',
    nav: [
      { text: 'Guide', link: '/guide/what-is-dosi' },
      { text: 'Reference', link: '/reference/protocol' },
      { text: 'GitHub', link: 'https://github.com/Bepely/dosi' },
    ],
    sidebar: {
      '/guide/': [
        {
          text: 'Introduction',
          items: [
            { text: 'What is DOSI?', link: '/guide/what-is-dosi' },
            { text: 'What is OCD?', link: '/guide/what-is-ocd' },
            { text: 'Getting Started', link: '/guide/getting-started' },
          ],
        },
        {
          text: 'How It Works',
          items: [
            { text: 'Session Lifecycle', link: '/guide/session-lifecycle' },
            { text: 'Agent Coordination', link: '/guide/agent-coordination' },
            { text: 'Idea Capture', link: '/guide/idea-capture' },
            { text: 'Vector Memory', link: '/guide/vector-memory' },
          ],
        },
        {
          text: 'Patterns',
          items: [
            { text: 'HQ Pattern', link: '/guide/hq-pattern' },
            { text: 'Multi-Project', link: '/guide/multi-project' },
            { text: 'Real-World Usage', link: '/guide/real-world' },
            { text: 'DOSI Agent', link: '/guide/dosi-agent' },
            { text: 'CLI Launcher', link: '/guide/cli-launcher' },
            { text: 'Status Line', link: '/guide/statusline' },
          ],
        },
      ],
      '/reference/': [
        {
          text: 'Reference',
          items: [
            { text: 'Full Protocol', link: '/reference/protocol' },
            { text: 'OCD Template', link: '/reference/ocd-template' },
            { text: 'Scaffold Files', link: '/reference/scaffold' },
            { text: 'Changelog', link: '/reference/changelog' },
          ],
        },
      ],
    },
    socialLinks: [
      { icon: 'github', link: 'https://github.com/Bepely/dosi' },
    ],
    footer: {
      message: 'Created by Bepely',
      copyright: 'Copyright (c) 2026 Nick Gogin. All rights reserved.',
    },
  },
})
