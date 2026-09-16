# SiteOS Cookie for Google Tag Manager

Load the SiteOS Cookie banner and synchronize Google Consent Mode v2 through GTM's native
consent APIs.

This repository is prepared for the Community Template Gallery. A Gallery listing is not yet
confirmed. Until it is available, import `template.tpl` manually.

## Installation

1. Configure and publish Cookie for the intended Project environment in
   [SiteOS](https://app.siteos.sh).
2. In GTM, open **Templates → Tag Templates → New → More → Import**, select `template.tpl`,
   review its permissions and save it.
3. Create a tag using **SiteOS Cookie**. Copy all five values from **Cookie → Installation**:
   Site public key, Runtime URL, Configuration URL, Analytics URL and Receipts URL.
   Use the exact environment-specific URLs; the public key is not an authentication secret.
4. Select **Consent Initialization – All Pages** as the firing trigger. Allow this consent
   manager to run before a visitor has made a choice; do not gate it on analytics or advertising
   consent.
5. Preview and verify the scenarios below before publishing the container.

Install one Cookie loader. Remove a replaced direct snippet, Custom HTML loader or another CMP
as part of the reviewed migration. Importing a template does not publish your GTM container.

## Consent and other tags

The template immediately sets `ad_storage`, `ad_user_data`, `ad_personalization`,
`analytics_storage`, `functionality_storage` and `personalization_storage` to `denied`.
`security_storage` defaults to `granted`. The configured Cookie policy and visitor choices
subsequently update the states through `updateConsentState`.

Regional rules and banner content are managed in SiteOS. The 500 ms `wait_for_update` value is
not permission to start optional tags. Configure the consent requirements and triggers of each
Google and non-Google tag separately. Basic versus Advanced Consent Mode depends on those tags
and the Cookie configuration; this loader alone does not establish either mode.

The template loads the same runtime and published configuration as the website snippet. Banner
appearance, languages, service selection, regional behavior, GPC, privacy controls and consent
storage settings therefore stay in Cookie; they do not need duplicate fields in GTM. Publish
configuration changes in SiteOS before testing their effect on the website.

For consent across subdomains, explicitly list every installation hostname and enable shared
subdomain consent in Cookie. Install the same public key on each hostname. Sharing is off by
default, applies only to the configured parent domain and keeps different banners separate.
The GTM template does not infer or expand the installation domain list.

For Basic mode, initialize GA4 on `siteos_analytics_granted` and Google Ads on
`siteos_ads_granted`, with their consent requirements enabled. Configure native GA4 withdrawal
control in Cookie with the actual measurement IDs. A consent update alone does not guarantee
that a previously blocked tag fires, or stop a library that has already loaded. Check scripts
outside GTM as well.

## Permissions

- Write the seven consent states listed above.
- Read/write the `__SITEOS_COOKIE_GTM_BOOTSTRAP__` configuration global.
- Call `SiteOSCookieLoader.onLoad` and `SiteOSCookie.registerGoogleConsentListener`.
- Load Cookie assets from the production `app.siteos.sh` and staging `siteosapp.xui.se` hosts.
  A custom host requires a reviewed local template permission change.

The template does not read the consent cookie. Configuration, consent persistence and the
banner are handled by the SiteOS runtime. Tag success confirms bootstrap and listener wiring;
verify banner/configuration readiness separately.

## Verify before publishing

Use GTM Preview / Tag Assistant and browser network/storage inspection to check:

- Fresh visit: denied defaults precede optional tags; the banner is reachable.
- Reject: optional collection remains blocked.
- Accept and granular choices: appropriate tags fire on the same page.
- Returning visit: the saved choice is applied correctly.
- Reopen and withdraw: consent updates and optional collection stops as configured.
- Slow or failed Cookie requests, recovery, GPC and each enabled regional policy.

Check representative pages and mobile controls. Template unit tests do not replace this
assembled website verification. Gallery availability does not imply Google CMP certification,
IAB TCF support or legal certification.

## Maintenance

This repository is a generated distribution of `pixel-point/siteos-platform`. The canonical
template lives at `packages/cookie-runtime/public/integrations/gtm/siteos-cookie.tpl`; public
documentation, license, verification and version history live beside it in `gallery/`.
Make changes upstream and use `pnpm cookie:gtm:sync`; do not maintain a second editable template.

`publication.json` records the source revision, whether that checkout had uncommitted changes,
file hashes and immutable template-version references. `metadata.yaml` uses commits from this
distribution repository, not the monorepo. Consumers choose whether to accept Gallery updates.

Run `node scripts/verify.mjs` with Node.js 22+ to verify the distribution. Run it with `--release`
to additionally require a version whose committed template equals the current template.
The first content commit may have an empty version list while a release is being prepared.

Report problems in [GitHub Issues](https://github.com/pixel-point/siteos-gtm-cookie/issues).

## License

The files distributed in this repository are provided under Apache License 2.0; see `LICENSE`.
This distribution license does not relicense the SiteOS application or grant rights to its brand.
