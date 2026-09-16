___TERMS_OF_SERVICE___
By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.
___INFO___
{
  "type": "TAG",
  "id": "siteos_cookie_consent_v11",
  "version": 1,
  "securityGroups": [],
  "displayName": "SiteOS Cookie",
  "brand": {
    "id": "siteos",
    "displayName": "SiteOS",
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGAAAABgCAMAAADVRocKAAAAXVBMVEUICAoAAAH///8HBwkICAoICAoJCQsICAoICApMaXEKCgz29vf5+fn7+/sMDA74+PhYWFkmJidra2x6ensUFBbd3d27u7zPz9CpqaqOjo/9/f1ISEnr6+ucnJw4ODpxYYYrAAAACnRSTlP3////ujj/N8EAe8IfqgAAAAlwSFlzAABxYwAAcWMBNfmKzAAAAxJJREFUeJztWtmO2zAMNMldZUPKku8zyf9/ZkHZm7RAAalbuWhRz4Od5EFjXkMycHG9fBTmEDAVH+/X4sKGjyEgZsPvxYdRA47gYKLCvBXFQc+vYGOKox7/iYMC/EJxqAH8Zyw4FsXB55uTIIrTRVGcLoridFEUp4ui+L9cRD/5lI+ADDtnSMGOsxMQMRMAua5zDPoh1Yo0AjIOoKvmYez7fpza1QEx5SMgNlDfb/jC2DhwRJkIiAlawUVEvPdeb4jjA1wmAmIyE5bi7QsiKFUSQ4oFDHcMx3uxtgxXawX9AxLiECcgBw3uZ+LixSJaZRMcHcVzKUpAhro+EHjs27WuH9VkcWNowGWwwEEVzhecHGxYb4vXHwYwGQgYZiXw2HfgmJldoBQRe6uBcxAMSiB437OGDNO4lcOalWB+piVT1QbktWAk2mJKZPZg5MgiE6ogBPlOsCup3jQaCYqXnkXW41h1+thKsp+cgYCedaCF1k/NQ5M16eETLSCGCu3GIIjo+6mp1Y4kMU3UohY3MbJeVCpQhspAmhEpamoYqpuq9aanXqREHLUGMqkpGYZ6vgWpC67anNVCliAriBxA3Qza0xa/GSIW53iZpTd91typ1zmQ7M0BU1pO+tjC2zhRr3OP5ash/D4BsQvQULBTkega2RvCGjchRkA/6k4gIVilDARzvOMkWLA2ATXxc8Tb5ElwyqCmDNOm/c3THeSgzUkwh/aF06t0s1rgPsV0qWAXaQf1TfMoSwyI9TRN+0WqPdzwGPcOkVAIKQ1n2qaWBYcmjC13+Rxjuhx1wFBLGQ70iKVGA8NXK9hmmYtIJ7vPfmDLUq/b+UNKR0jvB/Ld7Bu0buhSdoTUftAj2tf4LiUus0uZfZP7QdeOy3cLyG16JO44qf2AwD3aaVuhhrmqAThth0rvB6SC13VdF0ZgTuqXX19jOXlV/tVFnJn/4b8SvoSTIIrTRVGcLoridFEUp4uiOF30F7iI99XrEDBxkfon95dATMWBJrB66NBXT4y+enI5LATqGX4vrpe3417/eXu/fgMh+umM7NkebAAAAABJRU5ErkJggg=="
  },
  "description": "Loads the versioned SiteOS Cookie runtime and synchronizes Google Consent Mode v2 through Tag Manager consent APIs.",
  "containerContexts": [
    "WEB"
  ],
  "categories": [
    "TAG_MANAGEMENT"
  ]
}
___TEMPLATE_PARAMETERS___
[
  {
    "type": "TEXT",
    "name": "publicKey",
    "displayName": "Site public key",
    "simpleValueType": true,
    "alwaysInSummary": true,
    "valueHint": "site_...",
    "help": "Copy the public key from Cookie Studio. It identifies a published site and is not a secret.",
    "valueValidators": [
      {
        "type": "REGEX",
        "args": [
          "^site_[A-Za-z0-9_-]{20,80}$"
        ]
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "runtimeUrl",
    "displayName": "Runtime URL",
    "simpleValueType": true,
    "valueHint": "https://app.siteos.sh/cookie-loader.js",
    "help": "Copy the full URL from Cookie Installation. Use the addresses for this environment.",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "configUrl",
    "displayName": "Configuration URL",
    "simpleValueType": true,
    "valueHint": "https://your-cookie-edge.example/api/public/v1/config/site_...",
    "help": "Copy the full URL from Cookie Installation. Use the addresses for this environment.",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "analyticsUrl",
    "displayName": "Analytics URL",
    "simpleValueType": true,
    "valueHint": "https://your-cookie-edge.example/api/public/v1/analytics/events",
    "help": "Copy the full URL from Cookie Installation. Use the addresses for this environment.",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "receiptsUrl",
    "displayName": "Receipts URL",
    "simpleValueType": true,
    "valueHint": "https://app.siteos.sh/api/public/v1/consent/receipts",
    "help": "Copy the full URL from Cookie Installation. Use the addresses for this environment.",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  }
]
___SANDBOXED_JS_FOR_WEB_TEMPLATE___
const setDefaultConsentState = require('setDefaultConsentState');
const updateConsentState = require('updateConsentState');
const setInWindow = require('setInWindow');
const callInWindow = require('callInWindow');
const injectScript = require('injectScript');
const callLater = require('callLater');

const runtimeUrl = data.runtimeUrl;
const defaultState = {
  ad_storage: 'denied',
  ad_user_data: 'denied',
  ad_personalization: 'denied',
  analytics_storage: 'denied',
  functionality_storage: 'denied',
  personalization_storage: 'denied',
  security_storage: 'granted',
  wait_for_update: 500
};

setDefaultConsentState(defaultState);
setInWindow('__SITEOS_COOKIE_GTM_BOOTSTRAP__', {
  publicKey: data.publicKey,
  configUrl: data.configUrl,
  analyticsUrl: data.analyticsUrl,
  receiptsUrl: data.receiptsUrl,
  googleConsentManagedExternally: true
}, true);

const applyConsent = state => updateConsentState(state);
let consentConnected = false;
let completed = false;
let injected = false;
let attempt = 0;
let failedAttempt = 0;

const connectConsent = () => {
  if (consentConnected) return;
  consentConnected = true;
  callInWindow('SiteOSCookie.registerGoogleConsentListener', applyConsent);
};
const onSuccess = () => {
  connectConsent();
  if (completed) return;
  completed = true;
  data.gtmOnSuccess();
};
const onFailure = () => {
  if (completed) return;
  completed = true;
  data.gtmOnFailure();
};
const onInjected = () => {
  if (injected) return;
  injected = true;
  // A late load may still connect consent after this GTM execution has already failed.
  if (runtimeUrl.indexOf('/cookie-loader.js') !== -1) callInWindow('SiteOSCookieLoader.onLoad', onSuccess, onFailure, connectConsent);
  else onSuccess();
};
const attemptFailed = currentAttempt => {
  if (injected || currentAttempt !== attempt || failedAttempt === currentAttempt) return;
  failedAttempt = currentAttempt;
  if (attempt < 3) callLater(requestScript);
  else onFailure();
};
const requestScript = () => {
  if (injected) return;
  attempt += 1;
  const currentAttempt = attempt;
  // GTM creates only one script element for a cache token, including failed requests.
  injectScript(runtimeUrl, onInjected, () => attemptFailed(currentAttempt), 'siteos-cookie-runtime-v12-attempt-' + currentAttempt);
};

requestScript();
___WEB_PERMISSIONS___
[
  {
    "instance": {
      "key": {"publicId": "access_consent", "versionId": "1"},
      "param": [
        {
          "key": "consentTypes",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {"type": 1, "string": "consentType"},
                  {"type": 1, "string": "read"},
                  {"type": 1, "string": "write"}
                ],
                "mapValue": [
                  {"type": 1, "string": "ad_storage"},
                  {"type": 8, "boolean": false},
                  {"type": 8, "boolean": true}
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {"type": 1, "string": "consentType"},
                  {"type": 1, "string": "read"},
                  {"type": 1, "string": "write"}
                ],
                "mapValue": [
                  {"type": 1, "string": "ad_user_data"},
                  {"type": 8, "boolean": false},
                  {"type": 8, "boolean": true}
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {"type": 1, "string": "consentType"},
                  {"type": 1, "string": "read"},
                  {"type": 1, "string": "write"}
                ],
                "mapValue": [
                  {"type": 1, "string": "ad_personalization"},
                  {"type": 8, "boolean": false},
                  {"type": 8, "boolean": true}
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {"type": 1, "string": "consentType"},
                  {"type": 1, "string": "read"},
                  {"type": 1, "string": "write"}
                ],
                "mapValue": [
                  {"type": 1, "string": "analytics_storage"},
                  {"type": 8, "boolean": false},
                  {"type": 8, "boolean": true}
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {"type": 1, "string": "consentType"},
                  {"type": 1, "string": "read"},
                  {"type": 1, "string": "write"}
                ],
                "mapValue": [
                  {"type": 1, "string": "functionality_storage"},
                  {"type": 8, "boolean": false},
                  {"type": 8, "boolean": true}
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {"type": 1, "string": "consentType"},
                  {"type": 1, "string": "read"},
                  {"type": 1, "string": "write"}
                ],
                "mapValue": [
                  {"type": 1, "string": "personalization_storage"},
                  {"type": 8, "boolean": false},
                  {"type": 8, "boolean": true}
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {"type": 1, "string": "consentType"},
                  {"type": 1, "string": "read"},
                  {"type": 1, "string": "write"}
                ],
                "mapValue": [
                  {"type": 1, "string": "security_storage"},
                  {"type": 8, "boolean": false},
                  {"type": 8, "boolean": true}
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {"isEditedByUser": true},
    "isRequired": true
  },
  {
    "instance": {
      "key": {"publicId": "inject_script", "versionId": "1"},
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {"type": 1, "string": "https://app.siteos.sh/cookie-loader.js*"},
              {"type": 1, "string": "https://siteosapp.xui.se/cookie-loader.js*"},
              {"type": 1, "string": "https://app.siteos.sh/cookie.js*"},
              {"type": 1, "string": "https://siteosapp.xui.se/cookie.js*"}
            ]
          }
        }
      ]
    },
    "clientAnnotations": {"isEditedByUser": true},
    "isRequired": true
  },
  {
    "instance": {
      "key": {"publicId": "access_globals", "versionId": "1"},
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {"type": 1, "string": "key"},
                  {"type": 1, "string": "read"},
                  {"type": 1, "string": "write"},
                  {"type": 1, "string": "execute"}
                ],
                "mapValue": [
                  {"type": 1, "string": "__SITEOS_COOKIE_GTM_BOOTSTRAP__"},
                  {"type": 8, "boolean": true},
                  {"type": 8, "boolean": true},
                  {"type": 8, "boolean": false}
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {"type": 1, "string": "key"},
                  {"type": 1, "string": "read"},
                  {"type": 1, "string": "write"},
                  {"type": 1, "string": "execute"}
                ],
                "mapValue": [
                  {"type": 1, "string": "SiteOSCookie.registerGoogleConsentListener"},
                  {"type": 8, "boolean": false},
                  {"type": 8, "boolean": false},
                  {"type": 8, "boolean": true}
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {"type": 1, "string": "key"},
                  {"type": 1, "string": "read"},
                  {"type": 1, "string": "write"},
                  {"type": 1, "string": "execute"}
                ],
                "mapValue": [
                  {"type": 1, "string": "SiteOSCookieLoader.onLoad"},
                  {"type": 8, "boolean": false},
                  {"type": 8, "boolean": false},
                  {"type": 8, "boolean": true}
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {"isEditedByUser": true},
    "isRequired": true
  }
]
___TESTS___
scenarios:
- name: Sets denied defaults and delegates updates to the SiteOS runtime
  code: |-
    const mockData = { publicKey: 'site_abcdefghijklmnopqrstuvwxyz', runtimeUrl: 'https://app.siteos.sh/cookie-loader.js?v=12', configUrl: 'https://edge.example/api/public/v1/config/site_abcdefghijklmnopqrstuvwxyz', analyticsUrl: 'https://edge.example/api/public/v1/analytics/events', receiptsUrl: 'https://app.siteos.sh/api/public/v1/consent/receipts' };
    let listener;
    mock('setInWindow', () => {});
    mock('injectScript', (url, onSuccess) => onSuccess());
    mock('callInWindow', (name, callback) => { if (name === 'SiteOSCookieLoader.onLoad') callback(); else if (name === 'SiteOSCookie.registerGoogleConsentListener') listener = callback; });
    runCode(mockData);
    assertApi('setDefaultConsentState').wasCalledWith({
      ad_storage: 'denied',
      ad_user_data: 'denied',
      ad_personalization: 'denied',
      analytics_storage: 'denied',
      functionality_storage: 'denied',
      personalization_storage: 'denied',
      security_storage: 'granted',
      wait_for_update: 500
    });
    listener({ analytics_storage: 'granted' });
    assertApi('updateConsentState').wasCalledWith({ analytics_storage: 'granted' });
    assertApi('gtmOnSuccess').wasCalled();
___NOTES___
Version 1.2.1 - Resilient loader v12, runtime 11.5.1. Copy all delivery URLs from Cookie Installation.
Failed initial asset requests retry up to three times through the supported callLater API. Browser network timeout bounds a stalled first request; the loaded bootstrap bounds runtime requests to eight seconds.
Manual or late recovery reconnects consent updates without changing a completed GTM tag result. Deploy the matching loader before publishing this template.
GTM success confirms bootstrap and consent listener registration; Cookie lifecycle evidence separately confirms configuration/UI readiness.
The script permission allows the SiteOS production and staging application hosts.
For a custom application host, review and add that exact asset URL to the template's
inject_script permission. Use Consent Initialization - All Pages; verify tag ordering,
consent updates, refusal and withdrawal in Tag Assistant before publishing the container.
